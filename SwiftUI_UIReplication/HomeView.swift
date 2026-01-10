import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack {
                appCell(title: "Spotify", view: SpotifyHomeView())
                appCell(title: "Bumble", view: BumbleHomeView())
                appCell(title: "Netfilx", view: NetflixHomeView())
            }
            .toolbarVisibility(.hidden, for: .navigationBar)
            .padding()
            .navigationTitle("UI Replications")
        }
    }
    
    func appCell(title: String, view: some View) -> some View {
        NavigationLink {
            view
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .homeItemTheme()
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
