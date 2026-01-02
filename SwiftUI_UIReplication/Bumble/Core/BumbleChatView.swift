import SwiftUI

struct BumbleChatView: View {
    @State private var users = [User]()
    var body: some View {
        ZStack {
            Color.bumbleWhite
            
            VStack(alignment: .leading, spacing: 10) {
                header
                matchQueueSection
                recentChats
                    .scrollIndicators(.hidden)
            }
            .task {
                await getData()
            }
        }
        .padding(10)
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        guard users.isEmpty else { return }
        do {
            users = try await DatabaseHelper().getUsers()
        } catch {
            print(error)
        }
    }
}

private extension BumbleChatView {
    var header: some View {
        HStack() {
            Image(systemName: "line.horizontal.3")
            
            Image(systemName: "magnifyingglass")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .foregroundStyle(.bumbleBlack)
    }
    
    var matchQueueSection: some View {
        var countMessage: AttributedString {
            var result = AttributedString("(\(users.count))")
            result.foregroundColor = .bumbleGray
            return result
        }
        
        return VStack(alignment: .leading) {
            Text("Match Queue " + countMessage)
            ScrollView(.horizontal) {
                LazyHStack(spacing: 10) {
                    ForEach(users) { user in
                        BumbleProfileImageView(
                            imageUrl: user.image,
                            percentageRemaining: Double.random(in: 0...1),
                            hasNewMessage: Bool.random()
                        )
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 80)
            }
            .padding(-10)
            .scrollIndicators(.hidden)
        }
    }
    
    var recentChats: some View {
        var message: AttributedString {
            var result = AttributedString("(recent)")
            result.foregroundColor = .bumbleGray
            return result
        }
        
        return VStack {
            HStack {
                Text("Chat " + message)
                Spacer()
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.title2)
            }
            
            ScrollView {
                LazyVStack(spacing: 15) {
                    ForEach(users) { user in
                        BumbleChatPreviewCell(
                            imageName: user.image,
                            percentageRemaining: Double.random(in: 0...1),
                            hasNewMessage: Bool.random(),
                            userName: user.fullName,
                            lastChatMessage: "This is my last chat message",
                            isYourMove: Bool.random()
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    BumbleChatView()
}
