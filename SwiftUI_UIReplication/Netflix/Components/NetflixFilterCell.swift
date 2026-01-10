import SwiftUI

struct NetflixFilterCell: View {
    let title: String
    let isSelected: Bool
    let isDropDown: Bool
    
    var body: some View {
        HStack {
            Text(title)
            
            if isDropDown {
                Image(systemName: "chevron.down")
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background {
            ZStack {
                Capsule()
                    .fill(.netflixDarkGray)
                    .opacity(isSelected ? 1 : 0)
                
                Capsule()
                    .stroke(lineWidth: 1)
            }
        }
        .foregroundStyle(.netflixLightGray)
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        
        VStack(spacing: 20) {
            NetflixFilterCell(title: "Movies", isSelected: false, isDropDown: false)
            NetflixFilterCell(title: "Movies", isSelected: true, isDropDown: false)
            NetflixFilterCell(title: "Movies", isSelected: false, isDropDown: true)
            NetflixFilterCell(title: "Movies", isSelected: true, isDropDown: true)
        }
    }
}
