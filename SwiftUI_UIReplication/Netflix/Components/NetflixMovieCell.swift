import SwiftUI

struct NetflixMovieCell: View {
    let title: String
    let image: String
    let isRecentlyAdded: Bool
    var ranking: Int?
    
    var body: some View {
        HStack(alignment: .bottom, spacing: -15) {
            if let ranking {
                Text("\(ranking)")
                    .font(.system(size: 100, weight: .medium, design: .serif))
                    .offset(y: 20)
                    .zIndex(100)
            }
            
            ZStack(alignment: .bottom) {
                ImageLoader(urlString: image, contentMode: .fill)
                
                VStack {
                    Text(title)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                    
                    Text("New")
                        .font(.caption)
                        .bold()
                        .padding(.horizontal, 5)
                        .background {
                            Rectangle()
                                .fill(.netflixRed)
                                .clipShape(.rect(cornerRadii: .init(topLeading: 3, bottomLeading: 0, bottomTrailing: 0, topTrailing: 3)))
                        }
                        .opacity(isRecentlyAdded ? 1 : 0)
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 10)
                .background {
                    LinearGradient(
                        colors: [
                            .netflixBlack.opacity(0),
                            .netflixBlack.opacity(0.4),
                            .netflixBlack.opacity(0.4),
                            .netflixBlack.opacity(0.4),
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
            }
            .frame(width: 90, height: 140)
            .clipShape(.rect(cornerRadius: 5))
        }
        .foregroundStyle(.netflixWhite)
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        
        VStack {
            NetflixMovieCell(
                title: "Movie",
                image: Constants.imageUrl,
                isRecentlyAdded: true
            )
            
            NetflixMovieCell(
                title: "Movie",
                image: Constants.imageUrl,
                isRecentlyAdded: false,
                ranking: 10
            )
        }
    }
}
