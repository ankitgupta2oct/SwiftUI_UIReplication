import SwiftUI

struct HomeView: View {
  var body: some View {
    VStack {
      NavigationLink {
        SpotifyHomeView()
      } label: {
        Text("Spotify")
          .bold()
          .font(.title3)
          .padding()
          .foregroundStyle(.spotifyWhite)
          .frame(maxWidth: .infinity)
          .background(.spotifyGreen)
          .clipShape(.capsule)
          .padding()
      }
    }
    .navigationTitle("UI Replications")
  }
}

#Preview {
  NavigationStack {
    HomeView()
  }
}
