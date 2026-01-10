import SwiftUI

struct FilterModel: Hashable {
    let title: String
    let isDropDown: Bool
}

extension FilterModel {
    static var mockFilters = [
        FilterModel(title: "Movies", isDropDown: true),
        FilterModel(title: "Shows", isDropDown: false),
        FilterModel(title: "Catagory", isDropDown: true)
    ]
}
