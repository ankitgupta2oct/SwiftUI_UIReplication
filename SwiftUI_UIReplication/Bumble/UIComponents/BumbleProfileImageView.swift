import SwiftUI

struct BumbleProfileImageView: View {
    let imageUrl: String
    let percentageRemaining: Double
    let hasNewMessage: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(.bumbleGray ,lineWidth: 2)
            
            Circle()
                .trim(from: 0, to: percentageRemaining)
                .stroke(.bumbleYellow, lineWidth: 4)
                .rotationEffect(.degrees(-90))
                .scaleEffect(x: -1, y: 1, anchor: .center)
            
            ImageLoader(urlString: imageUrl)
                .clipShape(.circle)
                .padding(5)
            
            if hasNewMessage {
                Circle()
                    .fill(.bumbleWhite)
                    .overlay {
                        Circle()
                            .fill(.bumbleYellow)
                            .padding(4)
                    }
                    .offset(x: 2, y: 2)
                    .frame(maxWidth: 20, maxHeight: 20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
            }
        }
        .frame(maxWidth: 60, maxHeight: 60)
    }
}

#Preview {
    VStack {
        BumbleProfileImageView(
            imageUrl: Constants.imageUrl,
            percentageRemaining: Double.random(in: 0...1),
            hasNewMessage: true
        )
        
        BumbleProfileImageView(
            imageUrl: Constants.imageUrl,
            percentageRemaining: Double.random(in: 0...1),
            hasNewMessage: false
        )
    }
}
