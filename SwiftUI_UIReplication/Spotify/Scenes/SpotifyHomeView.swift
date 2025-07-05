import SwiftUI

struct SpotifyHomeView: View {
  @State private var user: User? = nil
  @State private var selectedCategory: SpotifyCategory = .all
  @State private var products: [Product] = []

  var body: some View {
    ZStack {
      Color.spotifyBlack
        .ignoresSafeArea()
      
      ScrollView(.vertical) {
        LazyVStack(pinnedViews: .sectionHeaders) {
          Section {
            VStack(spacing: 20) {
              recentProducts
                .padding(.horizontal, 8)
              
              ForEach(products) { product in
                SpotifyNewReleaseCell(thumbnail: product.thumbnail, heading: product.brand ?? "", subHeading: product.category, tittle: product.title, subTittle: product.description) {
                  print("Added to list")
                } playPressed: {
                  print("playPressed")
                }

              }
            }
            .padding()
          } header: {
            header
              .background(.spotifyBlack)
          }
        }
      }
      .scrollIndicators(.hidden)
      .clipped()
    }
    .task {
      await getData()
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
          ForEach(SpotifyCategory.allCases, id: \.self) { category in
            SpotifyCategoryCell(
              tittle: category.rawValue.capitalized,
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
    .padding(.leading, 8)
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
