//  Converted with Swiftify v1.0.6221 - https://objectivec2swift.com/
//
//  Configurator.h
//  GoT
//
//  Created by Paciej on 25/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
import Foundation
class Configurator: NSObject {
    class func configuredMainViewController() -> MainViewController {
        let asyncLoadConfiguration = Configurator.configuredCharactersAsyncLoadConfiguration()
        let loader = Configurator.configuredLoader()
        let repository = Configurator.configuredArticlesRepository()
        let dataSource = Configurator.configuredArticlesDataSource()
        return MainViewController(loader: loader, asyncLoadConfiguration: asyncLoadConfiguration, dataSource: dataSource, articlesRepository: repository)
    }

    class func configuredDetailsViewController(with article: Article, favourite: Bool) -> DetailsViewController {
        return DetailsViewController(article: article, favourite: favourite)
    }

    class func configuredArticlesRepository() -> ArticlesRepository {
        return ArticlesRepository(defaults: UserDefaults.standard)
    }


    class func configuredArticlesDataSource() -> DataSource {
        return DataSource(cellConfigureBlock: nil, cellReuseIdentifier: kCellReuseIdentifier)
    }

    class func configuredLoader() -> Loader {
        let session = URLSession(configuration: URLSessionConfiguration.default)
        return Loader(webserviceURLString: "", session: session)
    }

    class func configuredCharactersAsyncLoadConfiguration() -> AsyncLoadConfiguration {
        return AsyncLoadConfiguration(responseParsingBlock: { (result) -> Any? in
            //var JSON: [String: Any]? = result.jsonObject() as? [String : Any]
            //TODO:
            let jsonObject: Any? = result.jsonObject()
            guard let JSON = jsonObject as? [String : Any] else {
                print("loadAsynchronously error: cannot create JSON object from " +
                    "server response.")
                return nil
            }
            let basePath: String? = (JSON[kArticleBaseURL] as? String)
            let items: [[String : Any]] = (JSON[kItems] as? [[String : Any]]) ?? [[:]]
            var articles = [Article]() /* capacity: items?.count */
            
            for item in items {
//                DispatchQueue.main.async {
//                    print(item[kId], item[kTitle], item[kAbstract], item[kArticleURL], item[kThumbnailURL])
//                }
                if let identifier = item[kId] as? Int,
                    let title = item[kTitle] as? String,
                    let abstract = item[kAbstract] as? String,
                    let urlString = item[kArticleURL] as? String,
                    let thumbnailUrl = item[kThumbnailURL] as? String,
                    let basePath = basePath {
                    //autoreleasepool {
                    
                        let article = Article(identifier: String(identifier),
                                              title: title,
                                              abstract: abstract,
                                              urlString: basePath + urlString,
                                              thumbnailURLString: thumbnailUrl)
                        articles.append(article)
                    //}
                }
            }
            return articles
        }, webserviceEndpoint: "http://gameofthrones.wikia.com/api/v1/Articles/Top", webserviceQuery: "?expand=1&category=Characters&limit=3")
    }
}
//
//  Configurator.m
//  GoT
//
//  Created by Paciej on 25/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
var kItems: String = "items"

var kId: String = "id"

var kTitle: String = "title"

var kAbstract: String = "abstract"

var kThumbnailURL: String = "thumbnail"

var kArticleBaseURL: String = "basepath"

var kArticleURL: String = "url"

var kCellReuseIdentifier: String = "MainViewControllerCell"
