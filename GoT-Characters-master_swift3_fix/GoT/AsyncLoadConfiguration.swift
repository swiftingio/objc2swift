//  Converted with Swiftify v1.0.6221 - https://objectivec2swift.com/
//
//  AsyncLoadConfiguration.h
//  GoT
//
//  Created by Paciej on 24/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
import Foundation
class AsyncLoadConfiguration: NSObject {
    private(set) var responseParsingBlock: ((_ result: Data) -> Any?)? 
    private(set) var webserviceEndpoint: String
    private(set) var webserviceQuery: String?

    init(responseParsingBlock: ((_ result: Data) -> Any?)?,
                  webserviceEndpoint: String,
                  webserviceQuery: String?) {
        
        self.responseParsingBlock = responseParsingBlock
        self.webserviceEndpoint = webserviceEndpoint
        self.webserviceQuery = webserviceQuery
        super.init()
    }

}
extension AsyncLoadConfiguration {
    class func from(_ article: Article) -> AsyncLoadConfiguration {
        return AsyncLoadConfiguration(responseParsingBlock: { (result) -> Any? in
            var data: Data?
            if  (UIImage(data: result) != nil) {
                data = result
            }
            return data!
        }, webserviceEndpoint: article.thumbnailURLString, webserviceQuery: nil)
    }
}
//
//  LoaderConfiguration.m
//  GoT
//
//  Created by Paciej on 24/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
