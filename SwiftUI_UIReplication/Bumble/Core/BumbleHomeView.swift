import SwiftUI
import SwiftfulUI

struct BumbleHomeView: View {
    @State private var filters = ["Everyone", "Tranding"]
    @State private var users = [User]()
    @State private var selectedIndex = 0
    @State private var currentSwapOffset: CGSize = .zero
    @State private var cardOffSets: [Int: Bool] = [:]
    @AppStorage("Bimble_Filter_Selction") private var selection = "Everyone"
    
    var body: some View {
        VStack(spacing: 12) {
            header
            BumbleFilterView(options: filters, selection: $selection)
            
            ZStack {
                if !users.isEmpty {
                    ForEach(users.enumerated(), id: \.offset) { (index, user) in
                        let isPrevious = (selectedIndex - 1) == index
                        let isCurrent = (selectedIndex) == index
                        let isNext = (selectedIndex + 1) == index
                        
                        if isPrevious || isCurrent || isNext {
                            let offSetValue = cardOffSets[user.id]
                            userProfileCell(user: user, index: index)
                                .zIndex(Double(users.count - index))
                                .offset(x: offSetValue == nil ? 0 : offSetValue == true ? 900 : -900)
                        }
                    }
                    
                    overlaySwipingIndicators
                        .zIndex(9999)
                    
                } else {
                    ProgressView()
                        .controlSize(.large)
                }
            }
            .frame(maxHeight: .infinity)
            .animation(.smooth, value: cardOffSets)
        }
        .task {
            await getData()
        }
        .padding()
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private func userDidSelect(index: Int, isLike: Bool) {
        let user = users[index]
        cardOffSets[user.id] = isLike
        
        selectedIndex += 1
    }
    
    private func revert() {
        guard users.indices.contains(selectedIndex - 1) else {
            return
        }
        
        let user = users[selectedIndex - 1]
        cardOffSets[user.id] = nil
        selectedIndex -= 1
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

private extension BumbleHomeView {
    var header: some View {
        HStack {
            HStack {
                Image(systemName: "line.horizontal.3")
                Image(systemName: "arrow.uturn.left")
                    .onTapGesture {
                        revert()
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("bumble")
                .bold()
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            
            NavigationLink {
                BumbleChatView()
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }

        }
        .font(.title2)
        .foregroundStyle(.bumbleBlack)
    }
    
    func userProfileCell(user: User, index: Int) -> some View {
        BumbleCardView(
            user: user,
            superLikePressed: nil,
            xmarkPressed: nil,
            likePressed: {
                userDidSelect(index: index, isLike: true)
            },
            rejectPressed: {
                userDidSelect(index: index, isLike: false)
            },
            sendComplimentPressed: nil,
            hideAndReportPressed: nil
        )
            .withDragGesture(
                .horizontal,
                minimumDistance: 50,
                resets: true,
                rotationMultiplier: 1.05,
                onChanged: { dragOffset in
                    currentSwapOffset = dragOffset
                },
                onEnded: { dragOffset in
                    if dragOffset.width < -100 {
                        userDidSelect(index: index, isLike: false)
                    } else if dragOffset.width > 100 {
                        userDidSelect(index: index, isLike: true)
                    }
                }
            )
    }
    
    var overlaySwipingIndicators: some View {
        ZStack {
            Circle()
                .fill(.black.opacity(0.4))
                .overlay {
                    Image(systemName: "xmark")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .scaleEffect(abs(currentSwapOffset.width) > 100 ? 1.5 : 1)
                .offset(x: min(-currentSwapOffset.width, 150))
                .offset(x: -100)
                .frame(width: 60, height: 60)
                .animation(.smooth, value: currentSwapOffset)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Circle()
                .fill(.black.opacity(0.4))
                .overlay {
                    Image(systemName: "checkmark")
                        .font(.title)
                        .fontWeight(.semibold)
                }
                .scaleEffect(abs(currentSwapOffset.width) > 100 ? 1.5 : 1)
                .offset(x: max(-currentSwapOffset.width, -150))
                .offset(x: 100)
                .frame(width: 60, height: 60)
                .animation(.smooth, value: currentSwapOffset)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
    }
}

#Preview {
    NavigationStack {
        BumbleHomeView()
    }
}
