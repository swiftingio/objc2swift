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
        var asyncLoadConfiguration = Configurator.configuredCharactersAsyncLoadConfiguration()
        var loader = Configurator.configuredLoader()
        var repository = Configurator.configuredArticlesRepository()
        var dataSource = Configurator.configuredArticlesDataSource()
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
        var session = URLSession(configuration: URLSessionConfiguration.default)
        return Loader(webserviceURLString: "", session: session)
    }

    class func configuredCharactersAsyncLoadConfiguration() -> AsyncLoadConfiguration {
        return
        AsyncLoadConfiguration
        id(NSData * result)
        do {
            var JSON: Any? = result.jsonObject()
            if JSON == nil {
                print("loadAsynchronously error: cannot create JSON object from " + 
                    "server response.")
                return nil
            }
            var basePath: String? = (JSON?[kArticleBaseURL] as? String)
            var items: [Any]? = (JSON?[kItems] as? String)
            var articles = [Any]() /* capacity: items?.count */
            for  
            do {
            }
            article =
            Article
                        item[kId]
                        item[kTitle]abstract:
            item[kAbstract]
                        "\(basePath)\(item[kArticleURL])"
                        item[kThumbnailURL]]
            articles?.append(article)
        }
    }
    var articles = ()
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