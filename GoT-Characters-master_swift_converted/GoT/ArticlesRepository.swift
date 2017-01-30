//  Converted with Swiftify v1.0.6221 - https://objectivec2swift.com/
//
//  ArticlesRepository.h
//  GoT
//
//  Created by Paciej on 25/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
import Foundation
class ArticlesRepository: NSObject {
    override init(defaults: UserDefaults) {
        super.init()
        
        self.defaults = defaults
        self.articles = self.getFavouriteArticlesFromDefaults()
        self.temporaryArticles = Set<AnyHashable>()
    
    }

    func savedFavouritesArticles() -> [Any] {
        return self.articles.allObjects
    }

    func saveFavouriteArticle(_ article: Article) {
        self.articles.append(article)
        self.saveFavouriteArticlesToDefaults()
    }

    func removeFavouriteArticle(_ article: Article) {
        self.articles.remove(at: self.articles.index(of: article) ?? -1)
        self.saveFavouriteArticlesToDefaults()
    }

    func isFavouriteArticle(_ article: Article) -> Bool {
        return self.articles.filtered(using: NSPredicate(format: "identifier == %@", article.identifier)).count > 0
        // This could cause a perfromance issue for large data
        // sets!? TODO: verify and find better solution
    }

    func storeArticlesTemporarily(_ articles: [Any]) {
        self.temporaryArticles += articles
    }

    func temporarilyStoredArticles() -> [Any] {
        return self.temporaryArticles.allObjects
    }


    func saveFavouriteArticlesToDefaults() {
        var archivedArticles = NSKeyedArchiver.archivedData(withRootObject: self.articles)
        self.defaults.set(archivedArticles, forKey: kSavedArticles)
        self.defaults.synchronize()
    }

    func getFavouriteArticlesFromDefaults() -> Set<AnyHashable> {
        var archivedArticles: Data? = self.defaults.object(forKey: kSavedArticles)
        var set: Set<AnyHashable>? = NSKeyedUnarchiver.unarchiveObject(withData: archivedArticles)
        if set.isEmpty {
            set = Set<AnyHashable>()
        }
        return set!
    }

    var defaults: UserDefaults!
    var articles = Set<AnyHashable>()
    var temporaryArticles = Set<AnyHashable>()
}
//
//  ArticlesRepository.m
//  GoT
//
//  Created by Paciej on 25/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//

var kSavedArticles: String = "SavedArticles"