import SwiftUI

struct SpotifyRecentCell: View {
  let imageUrl: String
  let tittle: String
  
  var body: some View {
    HStack {
      ImageLoader(urlString: imageUrl)
        .frame(width: 55, height: 55)
      
      Text(tittle)
        .font(.callout)
        .fontWeight(.semibold)
        .lineLimit(2)
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
    }
    .frame(maxWidth: .infinity, alignment: .leading)
    .foregroundStyle(.spotifyWhite)
    .background(.spotifyDarkGray)
    .clipShape(.rect(cornerRadius: 8))
  }
}

#Preview {
  ZStack {
    Color.spotifyBlack
      .ignoresSafeArea()
    
    VStack {
      HStack {
        SpotifyRecentCell(imageUrl: Constants.imageUrl, tittle: "Some random tittle")
        SpotifyRecentCell(imageUrl: Constants.imageUrl, tittle: "Some random tittle")
      }
      HStack {
        SpotifyRecentCell(imageUrl: Constants.imageUrl, tittle: "Some random tittle")
        SpotifyRecentCell(imageUrl: Constants.imageUrl, tittle: "Some random tittle")
      }
    }
  }
}
