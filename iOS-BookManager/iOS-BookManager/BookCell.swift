import UIKit

class BookCell: UITableViewCell {
    
    var bookTitleLabel: UILabel!
    var bookPriceLabel: UILabel!
    var bookBoughtDateLabel: UILabel!
    var bookImage: UIImage!
    var bookImageView: UIImageView!
    var bookEditLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bookTitleLabel = UILabel(frame: CGRect.zero)
        bookTitleLabel.textAlignment = .left
        contentView.addSubview(bookTitleLabel)
        
        bookPriceLabel = UILabel(frame: CGRect.zero)
        bookPriceLabel.textAlignment = .left
        contentView.addSubview(bookPriceLabel)
        
        bookBoughtDateLabel = UILabel(frame: CGRect.zero)
        bookBoughtDateLabel.textAlignment = .left
        contentView.addSubview(bookBoughtDateLabel)
        
        bookImage = UIImage(named: "no_image.png")
        bookImageView = UIImageView(image: bookImage)
        contentView.addSubview(bookImageView)
        
        bookEditLabel = UILabel()
        bookEditLabel.text = ">"
        contentView.addSubview(bookEditLabel)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bookTitleLabel.frame = CGRect(x: 90, y: -25, width: frame.width - 100, height: frame.height)
        bookPriceLabel.frame = CGRect(x: 90, y: 25, width: 120, height: frame.height)
        bookBoughtDateLabel.frame = CGRect(x: frame.width - 150, y: 25, width: 120, height: frame.height)
        bookImageView.frame = CGRect(x: 5, y: 0, width: frame.height*(210/297), height: frame.height)
        bookEditLabel.frame = CGRect(x: frame.width - 20, y: 0, width: 10, height: frame.height)
    }
    
    func registCell(book: Book) {
        // セルに書籍データを登録！
        bookTitleLabel.text = book.name
        bookPriceLabel.text = String(describing: book.price) + R.string.localizable.taxout()
        bookBoughtDateLabel.text = book.boughtDate
        bookImageView.image = UIImage(named: book.imagePath)
    }
    
}
