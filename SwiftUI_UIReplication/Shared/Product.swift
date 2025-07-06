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

extension Product {
  static let mock = Product(
    id: 1,
    title: "iPhone 18",
    description: "Brand new iPhone 18",
    price: 500,
    discountPercentage: 0,
    rating: 5,
    stock: 10,
    brand: "Apple",
    category: "Phone",
    thumbnail: "https://w7.pngwing.com/pngs/378/624/png-transparent-iphone-14-thumbnail.png",
    images: [
      "https://www.pngwing.com/en/free-png-aqhbt"
    ],
    meta: ProductMetaData(createdAt: .now)
  )
}
