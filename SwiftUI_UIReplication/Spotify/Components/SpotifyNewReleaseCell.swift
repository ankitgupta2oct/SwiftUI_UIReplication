import SwiftUI

struct SpotifyNewReleaseCell: View {
  let thumbnail: String
  let heading: String
  let subHeading: String
  let tittle: String
  let subTittle: String
  
  var addToPlaylistPressed: (() -> Void)? = nil
  var playPressed: (() -> Void)? = nil

  var body: some View {
    VStack(alignment: .leading) {
      headerView
      
      releaseDetailView
        .background(.spotifyDarkGray)
        .clipShape(.rect(cornerRadius: 10))
    }
  }
  
  private var headerView: some View {
    HStack {
      ImageLoader(urlString: thumbnail)
        .frame(width: 50, height: 50)
        .clipShape(.circle)
      VStack(alignment: .leading) {
        Text(heading.capitalized)
          .font(.callout)
          .foregroundStyle(.spotifyLightGray)
        Text(subHeading.capitalized)
          .font(.title2)
          .fontWeight(.medium)
          .foregroundStyle(.spotifyWhite)
      }
    }
  }
  
  private var releaseDetailView: some View {
    HStack(spacing: 0) {
      ImageLoader(urlString: thumbnail)
        .frame(width: 140, height: 140)
      VStack(alignment: .leading) {
        Text(heading.capitalized)
          .font(.callout)
          .lineLimit(1)
          .foregroundStyle(.spotifyLightGray)
        Text(subHeading.capitalized)
          .font(.title2)
          .lineLimit(1)
          .fontWeight(.medium)
          .foregroundStyle(.spotifyWhite)
        
        Spacer()
        
        HStack {
          Image(systemName: "plus.circle")
            .foregroundStyle(.spotifyLightGray)
            .font(.title2)
            .padding(20)
            .offset(x: -20)
            .background(.clear)
            .contentShape(.rect)
            .onTapGesture {
              addToPlaylistPressed?()
            }
          
          Spacer()
          
          Image(systemName: "plus.circle.fill")
            .foregroundStyle(.spotifyWhite)
            .font(.title2)
            .padding(20)
            .offset(x: 20)
            .background(.clear)
            .contentShape(.rect)
            .onTapGesture {
              playPressed?()
            }
        }
//        .padding(.bottom, 5)
      }
        .padding(8)
        .frame(maxWidth: .infinity, maxHeight: 140)
    }
  }
}

#Preview {
  ZStack {
    Color.spotifyBlack
      .ignoresSafeArea()
    
    SpotifyNewReleaseCell(thumbnail: Constants.imageUrl, heading: "Apple", subHeading: "Smartphone", tittle: "New iPhone released", subTittle: "Get latest iPhone from neast store")
      .frame(height: 300)
  }
}
