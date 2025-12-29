import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack {
                NavigationLink {
                    SpotifyHomeView()
                } label: {
                    Text("Spotify")
                        .frame(maxWidth: .infinity)
                        .homeItemTheme()
                }
                NavigationLink {
                    BumbleHomeView()
                } label: {
                    Text("Bumble")
                        .frame(maxWidth: .infinity)
                        .homeItemTheme()
                }
            }
            .padding()
            .navigationTitle("UI Replications")
        }
    }
}

fileprivate struct HomeItemModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .bold()
            .font(.title3)
            .padding()
            .foregroundStyle(.spotifyWhite)
            .background(.spotifyGreen)
            .clipShape(.capsule)
    }
}

fileprivate extension View {
    func homeItemTheme() -> some View {
        self.modifier(HomeItemModifier())
    }
}

#Preview {
  NavigationStack {
    HomeView()
  }
}
