import UIKit

class BookCell: UITableViewCell {
    
    let bookTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    let bookPriceLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    let boughtDateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    let bookEditLabel: UILabel = {
        let label = UILabel()
        label.text = ">"
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16.0)
        label.textAlignment = .left
        return label
    }()
    
    let bookImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .center
        view.backgroundColor = UIColor.gray
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
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
        bookPriceLabel.text = String(describing: book.price) + R.string.localizable.taxout()
        boughtDateLabel.text = book.boughtDate
        bookImageView.image = UIImage(named: book.imagePath)
    }
    
}

extension BookCell {
    func setBookCellLayout() {
        
        contentView.addSubview(bookImageView)
        contentView.addSubview(bookTitleLabel)
        contentView.addSubview(bookPriceLabel)
        contentView.addSubview(boughtDateLabel)
        contentView.addSubview(bookEditLabel)
        
        bookImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5.0).isActive = true
        bookImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2).isActive = true
        bookImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        bookTitleLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15.0).isActive = true
        bookTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10.0).isActive = true
        bookTitleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.68).isActive = true
        
        bookPriceLabel.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 15.0).isActive = true
        bookPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10.0).isActive = true
        
        boughtDateLabel.trailingAnchor.constraint(equalTo: bookTitleLabel.trailingAnchor).isActive = true
        boughtDateLabel.centerYAnchor.constraint(equalTo: bookPriceLabel.centerYAnchor).isActive = true
        
        bookEditLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5.0).isActive = true
        bookEditLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
    }
}
