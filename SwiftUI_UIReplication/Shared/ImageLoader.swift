import SwiftUI
import SDWebImageSwiftUI

struct ImageLoader: View {
  var urlString: String = ""
  var contentMode: ContentMode = .fit
  
    var body: some View {
        Rectangle()
        .overlay {
          SDWebImageLoader(urlString: urlString, contentMode: contentMode)
        }
        .clipped()
    }
}

fileprivate struct SDWebImageLoader: View {
  let urlString: String
  let contentMode: ContentMode
  
  var body: some View {
    WebImage(url: URL(string: urlString))
      .resizable()
      .indicator(.activity)
      .aspectRatio(contentMode: contentMode)
      .allowsHitTesting(false)
  }
}

#Preview {
    ImageLoader(urlString: Constants.imageUrl, contentMode: .fill)
      .frame(width: 200, height: 200)
}
