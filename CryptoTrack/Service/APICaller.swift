import Foundation

final class APICaller {
    static let shared = APICaller()
    struct Constants {
        static var apiKey: String = ""
        static let Endpoint = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"
    }
    
    func getAllCryptoData(completion: @escaping (Result<[Crypto],Error>) -> ()) {
        guard let url = URL(string: Constants.Endpoint) else { return }
        var request = URLRequest(url: url)
        request.setValue(Constants.apiKey, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            do {
                guard let cryptoList = try JSONDecoder().decode(CryptoListResponse.self, from: data).data else { return }
                completion(.success(cryptoList))
            } catch {
                print(error)
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
   
}
