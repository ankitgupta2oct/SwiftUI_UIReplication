import SwiftUI

struct ImageTittleView: View {
  let imageUrl: String
  let tittle: String
  
  var body: some View {
    VStack {
      ImageLoader(urlString: imageUrl)
        .frame(width: 120, height: 120)
        .clipShape(.rect(cornerRadius: 12))

      Text(tittle)
        .font(.callout)
        .fontWeight(.medium)
        .foregroundStyle(.spotifyLightGray)
        .lineLimit(2)
        .multilineTextAlignment(.center)
    }
    .frame(width: 120)
  }
}

#Preview {
  ImageTittleView(imageUrl: Constants.imageUrl, tittle: "Hello World!!!!")
}
