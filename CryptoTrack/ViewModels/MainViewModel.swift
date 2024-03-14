import Foundation

class MainViewModel {
    var delegate: CryptoViewCellViewModelDelegate?
    
    func getAllCryptos() {
        APICaller.shared.getAllCryptoData { [weak self] result in
            switch result {
            case .success(let cryptos):
                let viewModels = cryptos.compactMap({ CryptoTableViewCellViewModel(name: $0.name, symbol: $0.symbol, price: "$\($0.quote.USD.price)", iconUrl: URL(string: "https://s2.coinmarketcap.com/static/img/coins/64x64/\($0.id).png")!) })
                self?.delegate?.didFetchCryptoData(viewModels: viewModels)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
