import SwiftUI

struct SpotifyProductCellView: View {
  let productImageUrl: String
  let tittle: String
  let subTittle: String
  let imageSize: CGFloat
  var onProductPressed: (() -> Void)? = nil
  var onMoreOptionsPressed: (() -> Void)? = nil
  
  var body: some View {
    HStack {
      ImageLoader(urlString: productImageUrl)
        .frame(width: imageSize, height: imageSize)
        .clipShape(.rect(cornerRadius: 10))
      
      VStack(alignment: .leading) {
        Text(tittle)
          .font(.body)
          .fontWeight(.medium)
          .foregroundStyle(.spotifyWhite)
          .lineLimit(1)
        Text(subTittle)
          .font(.callout)
          .foregroundStyle(.spotifyLightGray)
          .lineLimit(2)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      
      Button {
        onMoreOptionsPressed?()
      } label: {
        Image(systemName: "ellipsis")
          .foregroundStyle(.spotifyWhite)
          .padding(20)
          .contentShape(.rect)
      }
    }
    .onTapGesture {
      onProductPressed?()
    }
  }
}

#Preview {
  let product: Product = .mock
  ZStack {
    Color.spotifyBlack
      .ignoresSafeArea()
    
    VStack {
      SpotifyProductCellView(
        productImageUrl: product.thumbnail,
        tittle: product.title,
        subTittle: product.description,
        imageSize: 50
      )
    }
  }
}
