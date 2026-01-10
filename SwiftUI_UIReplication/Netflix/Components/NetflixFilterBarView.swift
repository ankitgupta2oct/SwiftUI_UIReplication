import SwiftUI

struct NetflixFilterBarView: View {
    var onXMarkPressed: (() -> Void)?
    var onfilterPressed: ((FilterModel) -> Void)?
    let filterModels: [FilterModel]
    var selectedFilter: FilterModel? = nil
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                if selectedFilter != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background {
                            Circle()
                                .stroke(lineWidth: 1)
                        }
                        .onTapGesture {
                            onXMarkPressed?()
                        }
                        .transition(AnyTransition.move(edge: .leading))
                        .padding(.horizontal, 10)
                }
                
                ForEach(filterModels, id: \.self) { filter in
                    if selectedFilter == nil || selectedFilter == filter {
                        NetflixFilterCell(
                            title: filter.title,
                            isSelected: filter == selectedFilter,
                            isDropDown: filter.isDropDown
                        )
                        .onTapGesture {
                            onfilterPressed?(filter)
                        }
                    }
                }
            }
            .animation(.bouncy, value: selectedFilter)
            .padding(.vertical, 4)
            .foregroundStyle(.netflixLightGray)
        }
        .scrollIndicators(.hidden)
    }
}

struct NetflixFilterBarViewPreview: View {
    @State private var selectedFilter: FilterModel? = nil
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            
            NetflixFilterBarView(
                onXMarkPressed: {
                    selectedFilter = nil
                },
                onfilterPressed: { filterModel in
                    selectedFilter = filterModel
                },
                filterModels: FilterModel.mockFilters,
                selectedFilter: selectedFilter
            )

        }
    }
}

#Preview {
    NetflixFilterBarViewPreview()
}
