import SwiftUI

struct SpotifyDesciptionCell: View {
  let subheadline: String
  let descriptionText: String
  let userName: String
  var onAddToPlaylistPressed: (() -> Void)?
  var onDownloadPressed: (() -> Void)?
  var onPressed: (() -> Void)?
  var onSharedPressed: (() -> Void)?
  var onMoreOptionsPressed: (() -> Void)?
  var onShuffledPressed: (() -> Void)?
  var onPlayPressed: (() -> Void)?
  
  var body: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(descriptionText)
        .foregroundStyle(.spotifyLightGray)
      
      madeForSection
      
      bottomActionsView
    }
    .frame(maxWidth: .infinity, alignment: .leading)
  }
  
  var madeForSection: some View {
    HStack {
      Image(systemName: "applelogo")
        .font(.title3)
        .foregroundStyle(.spotifyGreen)
      
      Text("Made for ")
        .foregroundStyle(.spotifyLightGray)
      +
      Text(userName)
        .foregroundStyle(.spotifyWhite)
        .bold()
    }
  }
  
  var bottomActionsView: some View {
    HStack {
      leftActions
        .frame(maxWidth: .infinity, alignment: .leading)

      rightActions
    }
    .font(.system(size: 20))
  }
  
  var leftActions: some View {
    HStack(spacing: 0) {
      Button {
        onAddToPlaylistPressed?()
      } label: {
        Image(systemName: "plus.circle")
          .padding(8)
          .background(.clear)
          .contentShape(.rect)
      }
      
      Button {
        onDownloadPressed?()
      } label: {
        Image(systemName: "arrow.down.circle")
          .padding(8)
          .background(.clear)
          .contentShape(.rect)
      }
      
      Button {
        onSharedPressed?()
      } label: {
        Image(systemName: "square.and.arrow.up")
          .padding(8)
          .background(.clear)
          .contentShape(.rect)
      }
      
      Button {
        onMoreOptionsPressed?()
      } label: {
        Image(systemName: "ellipsis")
          .padding(8)
          .background(.clear)
          .contentShape(.rect)
      }
    }
      .offset(x: -8)
      .foregroundStyle(.spotifyWhite)
  }
  
  var rightActions: some View {
    HStack(spacing: 0) {
      Button {
        onShuffledPressed?()
      } label: {
        Image(systemName: "shuffle")
          .padding(8)
          .background(.clear)
          .contentShape(.rect)
      }
      
      Button {
        onPlayPressed?()
      } label: {
        Image(systemName: "play.circle.fill")
          .padding(8)
          .background(.clear)
          .contentShape(.rect)
      }
      .font(.system(size: 40))
    }
    .foregroundStyle(.spotifyGreen)
  }
}

#Preview {
  let mock = Product.mock
  ZStack {
    Color.spotifyBlack
      .ignoresSafeArea()
    
    SpotifyDesciptionCell(
      subheadline: mock.title,
      descriptionText: mock.description,
      userName: "Ankit"
    )
  }
}
