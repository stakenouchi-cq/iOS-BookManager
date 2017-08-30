import Foundation

class Book {
    var id: Int
    var name: String
    var price: Int
    var boughtDate: String
    var imagePath: String
    
    init(id: Int, name: String, price: Int, boughtDate: String, imagePath: String) {
        self.id = id
        self.name = name
        self.price = price
        self.boughtDate = boughtDate
        self.imagePath = imagePath
    }
    
}
