import SwiftUI

struct SpotifyPlaylistHeaderCell: View {
  let imageUrl: String
  let tittle: String
  let subTittle: String
  let shadowColor: Color
  let height: CGFloat
  
  var body: some View {
    ImageLoader(urlString: imageUrl, contentMode: .fill)
      .frame(maxWidth: .infinity)
      .frame(height: height)
      .overlay (
        VStack(alignment: .leading) {
          Text(tittle)
            .lineLimit(1)
            .font(.headline)
          Text(subTittle)
            .lineLimit(2)
            .font(.largeTitle)
            .bold()
        }
        .foregroundStyle(.spotifyWhite)
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background {
          LinearGradient(colors: [
            shadowColor.opacity(0.01),
            shadowColor
          ], startPoint: .top, endPoint: .bottom)
        }
        , alignment: .bottomLeading
      )
  }
}

#Preview {
  ZStack(alignment: .top) {
    Color.spotifyBlack
      .ignoresSafeArea()
    
    SpotifyPlaylistHeaderCell(imageUrl: Constants.imageUrl, tittle: "My Tittle", subTittle: "My subtittle will be here", shadowColor: .black, height: 300)
      .ignoresSafeArea()
  }
}
