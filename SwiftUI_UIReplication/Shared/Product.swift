import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable, Identifiable {
  let id: Int
  let title, description: String
  let price: Double
  let discountPercentage, rating: Double
  let stock: Int
  let brand: String?
  let category: String
  let thumbnail: String
  let images: [String]
  let meta: ProductMetaData
}

struct ProductMetaData: Codable {
  let createdAt: Date
}
