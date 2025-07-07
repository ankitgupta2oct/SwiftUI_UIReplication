import SwiftUI

struct SpotifyPlaylistView: View {
  @Environment(\.dismiss) var dismiss
  @State private var products: [Product] = []
  @State private var showHeader = false
  let product: Product
  let userName: String
  
  var body: some View {
    ZStack(alignment: .top) {
      Color.spotifyBlack
        .ignoresSafeArea()
      
      content
        .ignoresSafeArea()
      
      headerView
    }
    .task {
      await getData()
    }
  }
  
  var content: some View {
    ScrollView {
      LazyVStack(spacing: 12) {
        
        spotifyPlaylistHeaderCellView
          .overlay {
            GeometryReader { proxy in
              VStack {
                Color.clear
                  .onAppear {
                    let y = proxy.frame(in: .global).maxY
                    showHeader = y < (y / 2)
                  }
                  .onChange(of: proxy.frame(in: .global).maxY) { _, newY in
                    showHeader = newY < (proxy.frame(in: .local).maxY / 2)
                  }
              }
            }
          }
        
        spotifyDesciptionCellView
          .padding(.leading)
        
        ForEach(products) { product in
          SpotifyProductCellView(
            productImageUrl: product.thumbnail,
            tittle: product.title,
            subTittle: product.description,
            imageSize: 50,
            onProductPressed: nil,
            onMoreOptionsPressed: nil
          )
        }
        .padding(.leading)
      }
    }
      .navigationBarBackButtonHidden()
  }
  
  var spotifyPlaylistHeaderCellView: SpotifyPlaylistHeaderCell {
    SpotifyPlaylistHeaderCell(
      imageUrl: product.thumbnail,
      tittle: product.title,
      subTittle: product.description,
      shadowColor: .spotifyBlack,
      height: 300
    )
  }
  
  var spotifyDesciptionCellView: SpotifyDesciptionCell {
    SpotifyDesciptionCell(
      subheadline: product.title,
      descriptionText: product.description,
      userName: userName,
      onAddToPlaylistPressed: nil,
      onDownloadPressed: nil,
      onPressed: nil,
      onSharedPressed: nil,
      onMoreOptionsPressed: nil,
      onShuffledPressed: nil,
      onPlayPressed: nil
    )
  }
  
  var headerView: some View {
    HStack {
      Button {
        dismiss()
      } label: {
        Image(systemName: "chevron.left")
          .padding()
          .foregroundStyle(.spotifyWhite)
          .background(.black.opacity(0.5))
          .clipShape(.circle)
      }
      Text("\(product.title)")
        .bold()
        .font(.title2)
        .lineLimit(1)
        .opacity(showHeader ? 1 : 0)
        .foregroundStyle(.spotifyWhite)
        .offset(y: showHeader ? 0 : -40)
        .frame(maxWidth: .infinity, alignment: .center)
      
      Image(systemName: "chevron.left")
        .padding()
        .foregroundStyle(.spotifyWhite)
        .opacity(0)
    }
    .padding(.horizontal)
    .padding(.bottom)
    .frame(maxWidth: .infinity)
    .background(showHeader ? .spotifyBlack : .clear)
    .animation(.smooth(duration: 0.2), value: showHeader)
  }
  
  func getData() async {
    do {
      products = try await DatabaseHelper().getProducts()
    } catch {
      print(error)
    }
  }
}

#Preview {
  SpotifyPlaylistView(product: .mock, userName: "Ankit")
}
