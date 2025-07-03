import SwiftUI

struct SpotifyCategoryCell: View {
  let tittle: String
  var isSelected: Bool = false
  
  var body: some View {
    Text(tittle)
      .font(.callout)
      .padding(.horizontal, 10)
      .padding(.vertical, 8)
      .frame(minWidth: 50)
      .foregroundStyle(isSelected ? .spotifyBlack : .spotifyWhite)
      .background(isSelected ? .spotifyGreen : .spotifyDarkGray)
      .clipShape(.rect(cornerRadius: 15))
  }
}

#Preview {
  VStack(spacing: 20) {
    SpotifyCategoryCell(tittle: "all")
    SpotifyCategoryCell(tittle: "Music")
    SpotifyCategoryCell(tittle: "Music", isSelected: true)
    SpotifyCategoryCell(tittle: "Music", isSelected: false)
  }
}
