//  Converted with Swiftify v1.0.6221 - https://objectivec2swift.com/
//
//  ArticlesRepository.h
//  GoT
//
//  Created by Paciej on 25/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
import Foundation
class ArticlesRepository {
    
    var defaults: UserDefaults!
    var articles: Set<Article>
    var temporaryArticles: Set<Article>
    
    init(defaults: UserDefaults) {
        self.defaults = defaults
        self.temporaryArticles = Set<Article>()
        self.articles = Set<Article>()
        //self.articles = self.getFavouriteArticlesFromDefaults()
        //self.articles = Set<Article>()
        //super.init()
        //TODO:
    }

    func savedFavouritesArticles() -> [Article] {
        return Array(self.articles)
    }

    func saveFavouriteArticle(_ article: Article) {
        self.articles.insert(article)
        self.saveFavouriteArticlesToDefaults()
    }

    func removeFavouriteArticle(_ article: Article) {
        if let index = self.articles.index(of: article){
            self.articles.remove(at: index)
        }
        self.saveFavouriteArticlesToDefaults()
    }

    func isFavouriteArticle(_ article: Article) -> Bool {
        return self.articles.filter { $0.identifier == article.identifier }.count > 0
        //return self.articles.filtered(using: NSPredicate(format: "identifier == %@", article.identifier)).count > 0
        // This could cause a perfromance issue for large data
        // sets!? TODO: verify and find better solution
    }

    func storeArticlesTemporarily(_ articles: [Article]) {
        for article in articles {
            self.temporaryArticles.insert(article)
        }
        //self.temporaryArticles += articles
    }

    func temporarilyStoredArticles() -> [Article] {
        return Array(self.temporaryArticles)
    }


    func saveFavouriteArticlesToDefaults() {
        var archivedArticles = NSKeyedArchiver.archivedData(withRootObject: Array(articles))
        self.defaults.set(archivedArticles, forKey: kSavedArticles)
        self.defaults.synchronize()
    }

    func getFavouriteArticlesFromDefaults() -> Set<Article> {
        guard let archivedArticles = self.defaults.object(forKey: kSavedArticles) as? Data,
            let set = NSKeyedUnarchiver.unarchiveObject(with: archivedArticles) as? [Article],
            set.count > 0 else {
            return Set<Article>()
        }
        return Set<Article>(set)
    }
}
//
//  ArticlesRepository.m
//  GoT
//
//  Created by Paciej on 25/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//

var kSavedArticles: String = "SavedArticles"
