import SwiftUI

struct SpotifyHomeView: View {
  @State private var user: User? = nil
  @State private var selectedCategory: SpotifyCategory = .all

  var body: some View {
    ZStack {
      Color.spotifyBlack
        .ignoresSafeArea()
      
      ScrollView(.vertical) {
        LazyVStack(spacing: 1, pinnedViews: .sectionHeaders) {
          Section {
            ForEach(0..<20) { _ in
              Rectangle()
                .fill(.red)
                .frame(width: 200, height: 200)
            }
          } header: {
            header
              .background(.spotifyBlack)
          }
        }
      }
      .scrollIndicators(.hidden)
      .clipped()
    }
    .task {
      await getData()
    }
    .toolbarVisibility(.hidden, for: .navigationBar)
  }
  
  private var header: some View {
    HStack(spacing: 0) {
      ZStack {
        if let user = user {
          ImageLoader(urlString: user.image)
            .background(Color.spotifyWhite)
            .clipShape(.circle)
        }
      }
      .frame(width: 35, height: 35)
      
      ScrollView(.horizontal) {
        HStack {
          ForEach(SpotifyCategory.allCases, id: \.self) { category in
            SpotifyCategoryCell(
              tittle: category.rawValue.capitalized,
              isSelected: selectedCategory == category
            )
            .onTapGesture {
              selectedCategory = category
            }
          }
        }
        .padding(.horizontal, 20)
      }
      .scrollIndicators(.hidden)
    }
    .padding(.vertical, 25)
    .padding(.leading, 8)
  }
  
  func getData() async {
    do {
      user = try await DatabaseHelper().getUsers().first
    } catch {
      print(error)
    }
  }
}

#Preview {
  SpotifyHomeView()
}
