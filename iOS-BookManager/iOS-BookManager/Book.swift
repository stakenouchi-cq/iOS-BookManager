import Foundation

struct Book {
    var name: String
    var price: Int
    var boughtDate: String
    var imagePath: String
    
    init(name: String, price: Int, boughtDate: String, imagePath: String) {
        self.name = name
        self.price = price
        self.boughtDate = boughtDate
        self.imagePath = imagePath
    }
    
}
