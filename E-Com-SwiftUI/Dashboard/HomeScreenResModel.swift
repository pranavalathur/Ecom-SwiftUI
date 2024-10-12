struct Section: Codable, Identifiable {
    var id: String // Change from UUID to String
    let type: String
    let title: String?
    let contents: [Content]?
}

struct Content: Codable, Identifiable {
    let id: String? // Change from UUID to String
    let title: String?
    let image_url: String?
    let sku: String?
    let product_name: String?
    let product_image: String?
    let product_rating: Int?
    let actual_price: String?
    let offer_price: String?
    let discount: String?
}
