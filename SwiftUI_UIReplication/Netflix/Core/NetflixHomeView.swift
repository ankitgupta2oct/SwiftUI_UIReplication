import SwiftUI
import SwiftfulUI

struct NetflixHomeView: View {
    @State private var selectedFilter: FilterModel?
    @State private var headerSize: CGSize = .zero
    @State private var user: User?
    @State private var items =  [String: [Product]]()
    @State private var heroProduct: Product? = nil
    @State private var scrollViewOffset: CGFloat = .zero
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            
            backgroundGradientLayer
            productsScrollView
            header
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
        .foregroundStyle(.netflixWhite)
        .task {
            await getData()
        }
    }
}

private extension NetflixHomeView {
    
    private var backgroundGradientLayer: some View {
        ZStack {
            LinearGradient(colors: [.netflixDarkGray.opacity(1), .netflixDarkGray.opacity(0)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            LinearGradient(colors: [.netflixDarkRed.opacity(0.5), .netflixDarkRed.opacity(0)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
        .frame(maxHeight: max(10, (400 + (scrollViewOffset * 0.75))))
        .opacity(scrollViewOffset < -250 ? 0 : 1)
        .animation(.easeInOut, value: scrollViewOffset)
    }
    
    var header: some View {
        VStack {
            VStack {
                navigationBarView
                if scrollViewOffset > -20 {
                    netflixFilterBarView
                        .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .background {
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            if headerSize == .zero {
                                headerSize = proxy.frame(in: .local).size
                            }
                        }
                        .onChange(of: proxy.frame(in: .local)) { _, newValue in
                            if headerSize == .zero {
                                headerSize = newValue.size
                            }
                        }
                }
            }
            .padding(.bottom, 8)
            .background {
                if scrollViewOffset < -70 {
                    Rectangle()
                        .fill(.clear)
                        .background(.ultraThinMaterial)
                        .brightness(-0.2)
                        .ignoresSafeArea()
                }
            }
            .animation(.smooth, value: scrollViewOffset)
            Spacer()
        }
    }
    
    var navigationBarView : some View {
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
    
    var productsScrollView: some View {
        ScrollViewWithOnScrollChanged(
            .vertical,
            showsIndicators: false) {
                VStack {
                    Rectangle()
                        .fill(.clear)
                        .frame(height: headerSize.height)
                    
                    if let heroProduct {
                        netflixHeroCell(heroProduct: heroProduct)
                        .padding(20)
                    }
                    
                    productsListView
                }
            } onScrollChanged: { offset in
                scrollViewOffset = min(0, offset.y)
            }
    }
    
    var productsListView: some View {
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
                                    isRecentlyAdded: product.isRecent,
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
