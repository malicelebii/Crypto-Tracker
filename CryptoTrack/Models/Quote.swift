import Foundation

struct Quote: Codable {
    var USD: UsdType

    enum CodingKeys: String, CodingKey {
        case USD
    }
}

struct UsdType: Codable {
    var price: Double
    var percentChange24h: Double

    enum CodingKeys: String, CodingKey {
        case price
        case percentChange24h = "percent_change_24h"
    }
        
}
