import UIKit

protocol CryptoViewCellViewModelDelegate {
    func didFetchCryptoData(viewModels: [CryptoTableViewCellViewModel])
}

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        return tableView
    }()
    
    var cellViewModels = [CryptoTableViewCellViewModel]()
    let mainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Crypto Tracker"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        mainViewModel.delegate = self
        mainViewModel.getAllCryptos()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension MainViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CryptoTableViewCell.identifier, for: indexPath) as? CryptoTableViewCell else {
            fatalError()
        }
        cell.configure(with: cellViewModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

extension MainViewController: CryptoViewCellViewModelDelegate {
    func didFetchCryptoData(viewModels: [CryptoTableViewCellViewModel]) {
        self.cellViewModels = viewModels
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

