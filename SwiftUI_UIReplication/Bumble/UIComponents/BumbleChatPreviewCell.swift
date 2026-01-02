import SwiftUI

struct BumbleChatPreviewCell: View {
    let imageName: String
    let percentageRemaining: Double
    let hasNewMessage: Bool
    let userName: String
    let lastChatMessage: String
    let isYourMove: Bool
    
    var body: some View {
        HStack {
            BumbleProfileImageView(imageUrl: imageName, percentageRemaining: percentageRemaining, hasNewMessage: hasNewMessage)
            
            VStack(alignment: .leading, spacing: 3) {
                HStack {
                    Text(userName)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    Spacer(minLength: 5)
                    if isYourMove {
                        Text("YOUR MOVE")
                            .padding(5)
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .background {
                                Capsule()
                                    .fill(.bumbleYellow)
                            }
                            
                    }
                }
                
                Text(lastChatMessage)
                    .font(.caption)
                    .lineLimit(1)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    let user = User.mock
    BumbleChatPreviewCell(
        imageName: user.image,
        percentageRemaining: Double.random(in: 0...1),
        hasNewMessage: Bool.random(),
        userName: user.fullName,
        lastChatMessage: "This was my last message",
        isYourMove: true
    )
    .padding()
}
