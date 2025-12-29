import SwiftUI

struct BumbleHomeView: View {
    @State private var filters = ["Everyone", "Tranding"]
    @AppStorage("Bimble_Filter_Selction") private var selection = "Everyone"
    
    var body: some View {
        VStack(spacing: 12) {
            header
            BumbleFilterView(options: filters, selection: $selection)
            Spacer()
        }
        .padding()
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
}

private extension BumbleHomeView {
    private var header: some View {
        HStack {
            HStack {
                Image(systemName: "line.horizontal.3")
                Image(systemName: "arrow.uturn.left")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("bumble")
                .bold()
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Image(systemName: "slider.horizontal.3")
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .foregroundStyle(.bumbleBlack)
    }
}

#Preview {
    BumbleHomeView()
}
