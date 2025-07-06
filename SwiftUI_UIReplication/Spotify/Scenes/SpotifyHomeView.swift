import SwiftUI

struct SpotifyHomeView: View {
  @State private var user: User? = nil
  @State private var selectedCategory: String = ""
  @State private var products: [Product] = []
  @State private var categories: [String] = []
  @State private var newRelasedProduct: Product?
  @State private var brandsProducts: [Dictionary<String, [Product]>.Element] = []

  var body: some View {
    ZStack {
      Color.spotifyBlack
        .ignoresSafeArea()
      
      ScrollView(.vertical) {
        LazyVStack(pinnedViews: .sectionHeaders) {
          Section {
            VStack(spacing: 20) {
              // Recent Products
              recentProducts
                .padding(.horizontal)
              
              // New released product
              if let product = newRelasedProduct {
                newReleasedProduct(product: product)
                  .padding(.horizontal)
              }
              
              // Products
              ForEach(Array(brandsProducts), id: \.0) { (brand, products) in
                brandProductsView(brand: brand, products: products)
              }
            }
          } header: {
            header
              .padding(.leading)
              .background(.spotifyBlack)
          }
        }
      }
      .scrollIndicators(.hidden)
      .clipped()
    }
    .task {
      await getData()
      categories = Array(Set(products.map { $0.category })).sorted()
      selectedCategory = categories.first ?? ""
      newRelasedProduct = products.max(by: { $0.meta.createdAt < $1.meta.createdAt })
      let brandsProducts = Dictionary(grouping: products) { $0.brand ?? "Others"}
      self.brandsProducts = brandsProducts.sorted {$0.value.count > $1.value.count}
    }
    .toolbarVisibility(.hidden, for: .navigationBar)
  }
  
  private var header: some View {
    HStack(spacing: 0) {
      ZStack {
        if let user = user {
          ImageLoader(urlString: user.image)
            .background(Color.spotifyWhite)
            .clipShape(.circle)
        }
      }
      .frame(width: 35, height: 35)
      
      ScrollView(.horizontal) {
        HStack {
          ForEach(categories, id: \.self) { category in
            SpotifyCategoryCell(
              tittle: category.capitalized,
              isSelected: selectedCategory == category
            )
            .onTapGesture {
              selectedCategory = category
            }
          }
        }
        .padding(.horizontal, 20)
      }
      .scrollIndicators(.hidden)
    }
    .padding(.vertical, 25)
  }
  
  private var recentProducts: some View {
    LazyVGrid(columns: [
      GridItem(.flexible(maximum: .infinity), spacing: 10, alignment: .center),
      GridItem(.flexible(maximum: .infinity), alignment: .center)
    ]) {
      ForEach(products.prefix(8)) { product in
        SpotifyRecentCell(imageUrl: product.thumbnail, tittle: product.title)
      }
    }
  }
  
  private func newReleasedProduct(product: Product) -> some View {
    SpotifyNewReleaseCell(thumbnail: product.thumbnail, heading: product.brand ?? "", subHeading: product.category, tittle: product.title, subTittle: product.description) {
      print("Added to list")
    } playPressed: {
      print("playPressed")
    }
  }
  
  private func brandProductsView(brand: String, products: [Product]) -> some View {
    VStack {
      Text(brand.capitalized)
        .font(.title)
        .fontWeight(.medium)
        .foregroundStyle(.spotifyWhite)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
      
      ScrollView(.horizontal) {
        HStack(alignment: .top) {
          ForEach(products) { product in
            ImageTittleView(imageUrl: product.thumbnail, tittle: product.title)
          }
        }
        .padding(.horizontal)
      }
    }
  }
  
  func getData() async {
    do {
      user = try await DatabaseHelper().getUsers().first
      products = try await DatabaseHelper().getProducts()
    } catch {
      print(error)
    }
  }
}

#Preview {
  SpotifyHomeView()
}
