import SwiftUI

struct InterestPillView: View {
    let userInterest: UserInterest
    
    var body: some View {
        HStack(spacing: 5) {
            iconView
            Text(userInterest.text)
                .lineLimit(1)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 8)
        .background(.bumbleLightYellow)
        .clipShape(.capsule)
    }
    
    @ViewBuilder
    var iconView: some View {
        switch userInterest.icon {
        case .emoji(let emoji):
            Text(emoji)
        case .icon(let icon):
            Image(systemName: icon)
        }
    }
}

#Preview {
    InterestPillView(userInterest: UserInterest(icon: .icon("person.crop.circle.fill"), text: "Person"))
    InterestPillView(userInterest: UserInterest(icon: .emoji("✌️"), text: "Vectory"))
}
