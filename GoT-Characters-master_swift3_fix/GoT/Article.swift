//  Converted with Swiftify v1.0.6221 - https://objectivec2swift.com/
//
//  Article.h
//  GoT
//
//  Created by Paciej on 25/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
import UIKit
class Article: NSObject, NSCoding {
    
    static var kArticleIdentifier: String = "privateIdentifier"
    
    static var kArticleTitle: String = "privateTitle"
    
    static var kArticleAbstract: String = "privateAbstract"
    
    static var kArticleThumbnailURL: String = "privateThumbnailURLString"
    
    static var kArticleThumbnailData: String = "thumbnailData"
    
    static var kArticleURL: String = "privateURLString"
    
    var title: String {
        return self.privateTitle
    }
    var identifier: String {
        return self.privateIdentifier
    }
    
    var abstract: String {
        return self.privateAbstract
    }
    
    var urlString: String {
        return self.privateUrlString
    }
    var thumbnailURLString: String {
        return self.privateThumbnailURLString
    }
    var thumbnailData: Data?

    init(identifier: String, title: String, abstract: String, urlString: String, thumbnailURLString: String) {
        
        self.privateIdentifier = identifier
        self.privateTitle = title
        self.privateAbstract = abstract
        self.privateUrlString = urlString
        self.privateThumbnailURLString = thumbnailURLString
    }

    func imageFromThumbnailData() -> UIImage? {
        return self.thumbnailData.flatMap { UIImage(data: $0) }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.privateIdentifier, forKey: Article.kArticleIdentifier)
        aCoder.encode(self.privateTitle, forKey: Article.kArticleTitle)
        aCoder.encode(self.privateAbstract, forKey: Article.kArticleAbstract)
        aCoder.encode(self.privateThumbnailURLString, forKey: Article.kArticleThumbnailURL)
        aCoder.encode(self.thumbnailData, forKey: Article.kArticleThumbnailData)
        aCoder.encode(self.privateUrlString, forKey: Article.kArticleURL)
    }

    required init?(coder aDecoder: NSCoder) {
    
        guard let identifier = aDecoder.decodeObject(forKey: Article.kArticleIdentifier) as? String,
            let title = aDecoder.decodeObject(forKey: Article.kArticleTitle) as? String,
            let abstract = aDecoder.decodeObject(forKey: Article.kArticleAbstract) as? String,
            let thumbnailURLString = aDecoder.decodeObject(forKey: Article.kArticleThumbnailURL) as? String,
            let URLstring = aDecoder.decodeObject(forKey: Article.kArticleURL) as? String
            else { return nil }
        self.privateIdentifier = identifier
        self.privateTitle = title
        self.privateAbstract = abstract
        self.privateUrlString = URLstring
        self.privateThumbnailURLString = thumbnailURLString
        self.thumbnailData = aDecoder.decodeObject(forKey: Article.kArticleThumbnailData) as? Data
        super.init()
    }

    var privateIdentifier: String
    var privateTitle: String
    var privateAbstract: String
    var privateThumbnailURLString: String
    var privateUrlString: String
}
