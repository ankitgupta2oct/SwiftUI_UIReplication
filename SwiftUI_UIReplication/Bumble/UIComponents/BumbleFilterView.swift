import SwiftUI

struct BumbleFilterView: View {
    let options: [String]
    @Binding var selection: String
    
    @Namespace private var namespace
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            ForEach(options, id: \.self) { option in
                VStack(spacing: 5) {
                    Text(option)
                        .frame(maxWidth: .infinity)
                        .bold(selection == option)
                        
                    
                    if (selection == option) {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(height: 1.5)
                            .matchedGeometryEffect(id: "selection", in: namespace)
                    }
                }
                .contentShape(.rect)
                .onTapGesture {
                    guard selection != option else { return }
                    selection = option
                }
                .foregroundStyle(selection == option ? .bumbleBlack : .bumbleGray)
            }
        }
        .background(alignment: .bottom) {
            Divider()
        }
        .animation(.smooth, value: selection)
    }
}

#Preview {
    BumbleFilterViewPreview()
}

struct BumbleFilterViewPreview: View {
    @State var options = ["Everyone", "Tranding"]
    @State var selection = "Everyone"
    var body: some View {
        BumbleFilterView(options: options, selection: $selection)
            .padding()
    }
}
