struct BookInfo {
    var title: String? = ""
    var authors = [String]()
    var pubDate: String = ""
    var description: String? = ""
    
    init?(dictionary: [String: AnyObject]) {
        guard let title = dictionary["title"] as? String else {
            return nil
        }
        
        guard let authors = dictionary["authors"] as? [String] else {
            return nil
        }
        
        guard let pubDate = dictionary["publishedDate"] as? String else {
            return nil
        }
        
        guard let description = dictionary["description"] as? String else {
            return nil
        }
        
        self.title = title
        self.authors = authors
        self.pubDate = pubDate
        self.description = description
    }
}
