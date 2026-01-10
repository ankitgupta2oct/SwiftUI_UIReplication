import SwiftUI
import SwiftfulUI

struct NetflixHomeView: View {
    @State private var selectedFilter: FilterModel?
    @State private var headerSize: CGSize = .zero
    @State private var user: User?
    @State private var items =  [String: [Product]]()
    @State private var heroProduct: Product? = nil
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            
            ScrollView {
                VStack {
                    Rectangle()
                        .fill(.clear)
                        .frame(height: headerSize.height)
                    
                    if let heroProduct {
                        netflixHeroCell(heroProduct: heroProduct)
                        .padding(20)
                    }
                    
                    productsView
                }
            }
            .scrollIndicators(.hidden)
            
            VStack {
                VStack {
                    header
                    netflixFilterBarView
                }
                .background {
                    GeometryReader { proxy in
                        Color.clear
                            .onAppear {
                                headerSize = proxy.frame(in: .global).size
                            }
                            .onChange(of: proxy.frame(in: .global)) { _, newValue in
                                headerSize = newValue.size
                            }
                    }
                }
                Spacer()
            }
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
        .foregroundStyle(.netflixWhite)
        .task {
            await getData()
        }
    }
}

private extension NetflixHomeView {
    var header : some View {
        HStack {
            Text("For You")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture { }
                
                Image(systemName: "magnifyingglass")
                    .onTapGesture { }
            }
        }
        .font(.title2)
    }
    
    func netflixHeroCell(heroProduct: Product) -> some View {
        NetflixHeroCell(
            imageName: heroProduct.thumbnail,
            isNetflixFlim: true,
            title: heroProduct.title,
            catogories: [heroProduct.category.capitalized, heroProduct.brand!.capitalized],
            onBackPressed: {
            }, onPlayPressed: {
            }, onListPressed: {
            }
        )
    }
    
    var netflixFilterBarView: some View {
        NetflixFilterBarView(
            onXMarkPressed: {
                selectedFilter = nil
            },
            onfilterPressed: { filterModel in
                selectedFilter = filterModel
            },
            filterModels: FilterModel.mockFilters,
            selectedFilter: selectedFilter
        )
    }
    
    var productsView: some View {
        LazyVStack(spacing: 20) {
            ForEach(items.sorted(by: {$0.key < $1.key}).enumerated(), id: \.offset) { rowIndex, item in
                VStack(alignment: .leading) {
                    Text(item.key.capitalized)
                        .font(.headline)
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(item.value.enumerated(), id: \.offset) { (index, product) in
                                NetflixMovieCell(
                                    title: product.title,
                                    image: product.thumbnail,
                                    isRecentlyAdded: Bool.random(),
                                    ranking: rowIndex == 1 ? index + 1 : nil
                                )
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getData() async {
      do {
          user = try await DatabaseHelper().getUsers().first
          let products = try await DatabaseHelper().getProducts()
          items = Dictionary(grouping: products, by: { $0.category })
          heroProduct = products[7]
      } catch {
        print(error)
      }
    }
}

#Preview {
    NetflixHomeView()
}
