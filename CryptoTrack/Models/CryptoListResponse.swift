import Foundation

class CryptoListResponse: Codable {
    var data: [Crypto]?
//    var status: Status?
}

struct Status: Codable {
    var timestamp: String?
    var error_code: Int?
    var error_message: String?
    var elapsed: Int?
    var credit_count: Int?
    var notice: String?
}
