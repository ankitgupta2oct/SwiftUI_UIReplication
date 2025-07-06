import SwiftUI

struct SpotifyPlaylistView: View {
  let product: Product
  let userName: String
  
  var body: some View {
    ZStack {
      Color.spotifyBlack
        .ignoresSafeArea()
      
      ScrollView {
        LazyVStack(spacing: 12) {
          SpotifyPlaylistHeaderCell(
            imageUrl: product.thumbnail,
            tittle: product.title,
            subTittle: product.description,
            shadowColor: .spotifyBlack,
            height: 300
          )
          
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
          .padding(.horizontal)
        }
      }
      .ignoresSafeArea()
    }
  }
}

#Preview {
  SpotifyPlaylistView(product: .mock, userName: "Ankit")
}
