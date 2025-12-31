import SwiftUI

struct BumbleCardView: View {
    let user: User
    
    private let interestColumns = [
        GridItem(.adaptive(minimum: 100), spacing: 12),
        GridItem(.adaptive(minimum: 100), spacing: 12)
    ]
    
    var superLikePressed: (() -> Void)?
    var xmarkPressed: (() -> Void)?
    var likePressed: (() -> Void)?
    var rejectPressed: (() -> Void)?
    var sendComplimentPressed: (() -> Void)?
    var hideAndReportPressed: (() -> Void)?
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                LazyVStack(spacing: 0) {
                    profileView
                        .frame(minHeight: proxy.size.height)
                    Group {
                        aboutMeView(imageHeight: proxy.size.height)
                        
                        locationSectionView
                        
                        footerSectionView
                        .padding(.vertical, 60)
                    }
                    .padding()
                }
            }
            .scrollIndicators(.hidden)
            .overlay(alignment: .bottomTrailing) {
                superLikeView
                    .padding()
            }
            .background(.bumbleBackgroundYellow)
            .clipShape(.rect(cornerRadius: 32))
        }
    }
    
    private var profileView: some View {
        ZStack(alignment: .bottomLeading) {
            ImageLoader(urlString: user.image, contentMode: .fill)
            
            VStack(alignment: .leading, spacing: 5) {
                Text("\(user.fullName), \(user.age)")
                    .fontWeight(.semibold)
                    .font(.title)
                
                HStack(spacing: 4) {
                    Image(systemName: "suitcase")
                    Text(user.work)
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "graduationcap")
                    Text(user.education)
                }
                
                BumbleHeartView()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .fontWeight(.medium)
            .font(.callout)
            .foregroundStyle(.bumbleWhite)
            .background {
                LinearGradient(
                    colors: [.clear, .black.opacity(0.6)],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
        }
    }
    
    private func aboutMeView(imageHeight: Double) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("About Me")
                .foregroundStyle(.bumbleGray)
                .font(.callout)
            
            Text(user.aboutMe)
                .font(.body)
                .fontWeight(.semibold)
            
            Button {
                sendComplimentPressed?()
            } label: {
                HStack {
                    BumbleHeartView()
                    Text("Send a compliment")
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(.bumbleYellow)
                .clipShape(.capsule)
            }
            .foregroundStyle(.primary)
            .fontWeight(.semibold)
            
            interestView(userInterests: user.basics, title: "My Basics")
            
            interestView(userInterests: user.hobbies, title: "My Hobbies")
            
            profileImagesView(imageHeight: imageHeight)
        }
    }
    
    private func profileImagesView(imageHeight: Double) -> some View {
        VStack(spacing: 0) {
            ForEach(user.otherImages, id: \.self) { image in
                ImageLoader(urlString: image, contentMode: .fill)
                    .frame(minHeight: imageHeight)
            }
        }
    }
    
    private func interestView(userInterests: [UserInterest], title: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.callout)
            
            LazyVGrid(columns: interestColumns, alignment: .leading, spacing: 12) {
                ForEach(userInterests) { interest in
                    InterestPillView(userInterest: interest)
                }
            }
        }
    }
    
    private var locationSectionView: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 5) {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                Text(user.firstName + "'s Location")
            }
            .foregroundStyle(.bumbleGray)
            .fontWeight(.medium)
            .font(.body)
            
            Text("10 km away")
                .font(.headline)
                .foregroundStyle(.bumbleBlack)
            
            InterestPillView(userInterest: UserInterest(icon: .emoji("🇮🇳"), text: "Live in India"))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var footerSectionView: some View {
        VStack {
            HStack {
                actionView(icon: "xmark")
                    .onTapGesture {
                        likePressed?()
                    }
                Spacer(minLength: 0)
                actionView(icon: "checkmark")
                    .onTapGesture {
                        rejectPressed?()
                    }
            }
            
            Text("Hide and report")
                .font(.headline)
                .foregroundStyle(.bumbleGray)
                .onTapGesture {
                    hideAndReportPressed?()
                }
        }
    }
    
    private func actionView(icon: String) -> some View {
        Circle()
            .fill(.bumbleYellow)
            .frame(width: 60, height: 60)
            .overlay {
                Image(systemName: icon)
                    .bold()
                    .font(.title2)
            }
    }
    
    private var superLikeView: some View {
        Image(systemName: "hexagon.fill")
            .foregroundStyle(.bumbleYellow)
            .font(.system(size: 60))
            .overlay {
                Image(systemName: "star.fill")
                    .font(.system(size: 30))
                    .onTapGesture {
                        superLikePressed?()
                    }
            }
    }
}

#Preview {
    BumbleCardView(user: .mock)
}
