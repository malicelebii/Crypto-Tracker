import UIKit

protocol CryptoViewCellViewModelDelegate {
    func didFetchCryptoData(viewModels: [CryptoTableViewCellViewModel])
}

class MainViewController: UIViewController {
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: CryptoTableViewCell.identifier)
        return tableView
    }()
    
    var cellViewModels = [CryptoTableViewCellViewModel]()
    let mainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupViewModel()
        fetchData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func setupNavigationBar() {
        title = "Crypto Tracker"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupUI() {
        setupNavigationBar()
        view.addSubview(tableView)
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupViewModel() {
        mainViewModel.delegate = self
    }
    
    func fetchData() {
        mainViewModel.getAllCryptos()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
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

