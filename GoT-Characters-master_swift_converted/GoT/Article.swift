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
    var title: String {
        return self.privateTitle
    }
    var identifier: String {
        return self.privateIdentifier
    }
    private(set) var: String = ""
    var urlString: String {
        return self.privateUrlString
    }
    var thumbnailURLString: String {
        return self.privateThumbnailURLString
    }
    var thumbnailData: Data?

    override init(identifier: String, title: String, urlString: String, urlString: String, thumbnailURLString: String) {
        super.init()
        
        self.privateIdentifier = identifier
        self.privateTitle = title
        self.privateAbstract =
        self.privateUrlString = urlString
        self.privateThumbnailURLString = thumbnailURLString
    
    }

    func imageFromThumbnailData() -> UIImage? {
        return UIImage(data: self.thumbnailData)
    }


    override func encode(withCoder aCoder: NSCoder) {
        aCoder.encodeObject(self.privateIdentifier, forKey: kArticleIdentifier)
        aCoder.encodeObject(self.privateTitle, forKey: kArticleTitle)
        aCoder.encodeObject(self.privateAbstract, forKey: kArticleAbstract)
        aCoder.encodeObject(self.privateThumbnailURLString, forKey: kArticleThumbnailURL)
        aCoder.encodeObject(self.thumbnailData, forKey: kArticleThumbnailData)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init()
        
        self.privateIdentifier = aDecoder.decodeObject(forKey: kArticleIdentifier)
        self.privateTitle = aDecoder.decodeObject(forKey: kArticleTitle)
        self.privateAbstract = aDecoder.decodeObject(forKey: kArticleAbstract)
        self.privateThumbnailURLString = aDecoder.decodeObject(forKey: kArticleThumbnailURL)
        self.thumbnailData = aDecoder.decodeObject(forKey: kArticleThumbnailData)
    
    }

    override func abstract() -> String {
        return self.privateAbstract
    }

    var privateIdentifier: String = ""
    var privateTitle: String = ""
    var privateAbstract: String = ""
    var privateThumbnailURLString: String = ""
    var privateUrlString: String = ""
}
//
//  Article.m
//  GoT
//
//  Created by Paciej on 25/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
var kArticleIdentifier: String = "privateIdentifier"

var kArticleTitle: String = "privateTitle"

var kArticleAbstract: String = "privateAbstract"

var kArticleThumbnailURL: String = "privateThumbnailURLString"

var kArticleThumbnailData: String = "thumbnailData"