import Foundation

struct APIConstants {
    static var apiKey: String = ""
    static let Endpoint = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"
}

protocol APICallerProtocol {
    func getAllCryptoData(completion: @escaping (Result<[Crypto],NetworkErrorEnum>) -> ())
}

final class APICaller: APICallerProtocol {
    static let shared = APICaller()
    
    func getAllCryptoData(completion: @escaping (Result<[Crypto],NetworkErrorEnum>) -> ()) {
        guard let url = URL(string: APIConstants.Endpoint) else { return }
        var request = URLRequest(url: url)
        request.setValue(APIConstants.apiKey, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if error != nil {
                completion(.failure(.networkError))
                return
            }
            guard let data = data else { completion(.failure(.noData)); return }
            do {
                guard let cryptoList = try JSONDecoder().decode(CryptoListResponse.self, from: data).data else { return }
                completion(.success(cryptoList))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
   
}
