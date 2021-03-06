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
    init(webserviceURLString urlString: String, session: URLSession) {
        self.webserviceURLString = urlString
        self.session = session
        super.init()
    }

    func loadAsynchronously(_ configuration: AsyncLoadConfiguration, callback: ((Any?) -> Void)?) {
        var urlString: String = webserviceURLString + configuration.webserviceEndpoint
        if let query = configuration.webserviceQuery {
            urlString += query
        }
            //TODO: use NSURLQueryItem  https://littlebitesofcocoa.com/128-nsurlqueryitem-nsurlcomponents
        guard let url = URLComponents(string: urlString)?.url else { return }
         let task: URLSessionDataTask? = self.session.dataTask(with: url) { (data, response, error) in
            if (error != nil) {
                DispatchQueue.main.async {
                    print("loadAsynchronously error: \(error.debugDescription)")
                }
                callback?(nil)
                return
            }
            let parsedObject: Any? = configuration.responseParsingBlock?(data!)
            callback?(parsedObject)
        }
        task?.resume()
    }

    var webserviceURLString: String
    var session: URLSession!
}
//
//  Loader.m
//  GoT
//
//  Created by Paciej on 21/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
