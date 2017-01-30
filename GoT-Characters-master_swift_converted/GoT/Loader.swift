//  Converted with Swiftify v1.0.6221 - https://objectivec2swift.com/
//
//  Loader.h
//  GoT
//
//  Created by Paciej on 21/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
import Foundation
class Loader: NSObject {
    override init(webserviceURLString urlString: String, session: URLSession) {
        super.init()
        
        self.webserviceURLString = urlString
        self.session = session
    
    }

    func loadAsynchronously(_ configuration: AsyncLoadConfiguration, callback: ?) {
        var urlString: String = "\(self.webserviceURLString)\(configuration.webserviceEndpoint)\(configuration.webserviceQuery)"
            //TODO: use NSURLQueryItem  https://littlebitesofcocoa.com/128-nsurlqueryitem-nsurlcomponents
        var components = URLComponents(string: urlString)
        var task: URLSessionDataTask? = self.session.dataTask(withURL: components.url, completionHandler: {(_ data: Data, _ response: URLResponse, _ error: Error) -> Void in
                if error {
                    print("loadAsynchronously error: \(error.debugDescription)")
                    callback(nil)
                    return
                }
                var parsedObject: Any? = configuration.responseParsingBlock(data)
                callback(parsedObject)
            })
        task?.resume()
    }

    var webserviceURLString: String = ""
    var session: URLSession!
}
//
//  Loader.m
//  GoT
//
//  Created by Paciej on 21/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//