import SwiftUI

struct NetflixHeroCell: View {
    let imageName: String
    let isNetflixFlim: Bool
    let title: String
    var catogories: [String]
    var onBackPressed: (() -> Void)?
    var onPlayPressed: (() -> Void)?
    var onListPressed: (() -> Void)?
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ImageLoader(urlString: imageName, contentMode: .fill)
            
            VStack(spacing: 8) {
                netflixFilmIndicatorView
                
                Text(title.capitalized)
                    .font(.system(size: 40, weight: .medium, design: .serif))
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
                
                catogoriesView
                
                actionView
            }
            .padding(24)
            .foregroundStyle(.netflixWhite)
            .background {
                LinearGradient(
                    colors: [
                        .netflixBlack.opacity(0),
                        .netflixBlack.opacity(0.4),
                        .netflixBlack.opacity(0.4),
                        .netflixBlack.opacity(0.4)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
        }
        .aspectRatio(0.8, contentMode: .fit)
        .clipShape(.rect(cornerRadius: 10))
        .onTapGesture {
            onBackPressed?()
        }
    }
}

private extension NetflixHeroCell {
    func heroCellActionView(title: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .fontWeight(.semibold)
            Text(title)
        }
        .padding(.vertical, 10)
    }
    
    var netflixFilmIndicatorView: some View {
        HStack {
            Text("N")
                .font(.largeTitle)
                .fontWeight(.black)
                .foregroundStyle(.netflixDarkRed)
            
            Text("FILMS")
                .kerning(3)
                .font(.subheadline)
                .fontWeight(.semibold)
        }
    }
    
    var catogoriesView: some View {
        HStack {
            ForEach(catogories, id: \.self) { catogory in
                Text(catogory)
                    .font(.callout)
                
                if catogory != catogories.last {
                    Circle()
                        .frame(width: 4, height: 4)
                }
            }
        }
    }
    
    var actionView: some View {
        HStack {
            heroCellActionView(title: "Play", icon: "play.fill")
                .frame(maxWidth: .infinity)
                .background(.netflixWhite)
                .foregroundStyle(.netflixDarkGray)
                .clipShape(.rect(cornerRadius: 10))
                .onTapGesture {
                    onPlayPressed?()
                }
            
            heroCellActionView(title: "My List", icon: "plus")
                .frame(maxWidth: .infinity)
                .background(.netflixDarkGray)
                .foregroundStyle(.netflixWhite)
                .clipShape(.rect(cornerRadius: 10))
                .onTapGesture {
                    onListPressed?()
                }
        }
    }
}

#Preview {
    NetflixHeroCell(
        imageName: Constants.imageUrl,
        isNetflixFlim: true,
        title: "Tom and jerry",
        catogories: ["Comedy", "Sifi", "Horror"],
        onBackPressed: {
//            print("onBackPressed")
        }, onPlayPressed: {
//            print("onPlayPressed")
        }, onListPressed: {
//            print("onListPressed")
        }
    )
    .padding(24)
}
