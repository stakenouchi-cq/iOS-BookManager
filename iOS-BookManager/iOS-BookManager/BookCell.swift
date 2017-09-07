import UIKit
import Kingfisher

class BookCell: UITableViewCell {
    
    fileprivate let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate let bookPriceLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate let purchaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate let bookEditLabel: UILabel = {
        let label = UILabel()
        label.text = ">"
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    fileprivate let bookImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setBookCellLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func registCell(book: Book) {
        // セルに書籍データを登録！
        bookTitleLabel.text = book.name
        bookPriceLabel.text = R.string.localizable.taxout(book.price)
        purchaseDateLabel.text = book.purchaseDate
        bookImageView.kf.setImage(with: book.imageURL)
    }
    
}

extension BookCell {
    fileprivate func setBookCellLayout() {
        
        contentView.addSubview(bookImageView)
        contentView.addSubview(bookTitleLabel)
        contentView.addSubview(bookPriceLabel)
        contentView.addSubview(purchaseDateLabel)
        contentView.addSubview(bookEditLabel)
        
        bookImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0).isActive = true
        bookImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2).isActive = true
        bookImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        bookTitleLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15.0).isActive = true
        bookTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        bookTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.68).isActive = true
        
        bookPriceLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15.0).isActive = true
        bookPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true
        
        purchaseDateLabel.trailingAnchor.constraint(equalTo: bookTitleLabel.trailingAnchor).isActive = true
        purchaseDateLabel.centerYAnchor.constraint(equalTo: bookPriceLabel.centerYAnchor).isActive = true
        
        bookEditLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5.0).isActive = true
        bookEditLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
}
