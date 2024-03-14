import Foundation

struct Crypto: Codable {
    var id: Int
    var name: String
    var symbol: String
    var quote: Quote
    
    enum CodingKeys: String, CodingKey {
        case id, name, symbol, quote
    }
}
