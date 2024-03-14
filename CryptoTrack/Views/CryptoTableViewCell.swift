import UIKit

class CryptoTableViewCell: UITableViewCell {
    static let identifier = "CryptoTableViewCell"
    
    // Subviews
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(symbolLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(iconImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //Layout
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let size: CGFloat = contentView.frame.size.height / 1.1
        iconImageView.frame = CGRect(x: 20, y: contentView.frame.size.height - size, width: size, height: size)
        
        nameLabel.sizeToFit()
        symbolLabel.sizeToFit()
        priceLabel.sizeToFit()
        
        nameLabel.frame = CGRect(x: 30 + size, y: 0, width: contentView.frame.size
            .width / 2, height: contentView.frame.size.height / 2)
        
        symbolLabel.frame = CGRect(x: 30 + size, y: contentView.frame.size.height / 2, width: contentView.frame.size
            .width / 2, height: contentView.frame.size.height / 2)
        priceLabel.frame = CGRect(x: contentView.frame.size.width / 2 , y: 0, width: (contentView.frame.size
            .width / 2) - 5, height: contentView.frame.size.height)
    }
    
    //Configure
    func configure(with viewModel: CryptoTableViewCellViewModel) {
        nameLabel.text = viewModel.name
        symbolLabel.text = viewModel.symbol
        priceLabel.text = viewModel.price
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: viewModel.iconUrl!)) { data, _, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.iconImageView.image = UIImage(data: data)
                }
            }
        }
        task.resume()
    }
}
