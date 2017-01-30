//  Converted with Swiftify v1.0.6221 - https://objectivec2swift.com/
//
//  MainViewController.h
//  GoT
//
//  Created by Paciej on 21/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
import UIKit
class MainViewController: UIViewController, UITableViewDelegate {
    override init(loader: Loader, asyncLoadConfiguration configuration: AsyncLoadConfiguration, dataSource: DataSource, articlesRepository: ArticlesRepository) {
        super.init(nibName: nil, bundle: nil)
        
        self.loader = loader
        self.configuration = configuration
        self.dataSource = dataSource
        self.articlesRepository = articlesRepository
        self.title = "Characters"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: kFavourite, style: .plain, target: self, action: #selector(self.rightBarButtonItemTapped))
        self.isFilterEnabled = false
    
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTableView()
        self.loadArticlesFromWebservice()
    }

    func loadTableView() {
        var onceToken: dispatch_once_t
        dispatch_once
        onceToken
    }

    var loader: Loader!
    var configuration: AsyncLoadConfiguration!
    var dataSource: DataSource!
    var articlesRepository: ArticlesRepository!
    var tableView: UITableView!
    var tableViewDataSource = [Any]()
    var isFilterEnabled: Bool = false
}
//
//  MainViewController.m
//  GoT
//
//  Created by Paciej on 21/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
import Masonry
var kFavourite: String = "Favourite"

var kAll: String = "All"

var dataSource = ()

var self = ()

var tableView = ()

weak var __weakSelf: __typeof__(self)? = self

var favCell: FavouriteTableViewCell? = (cell as? FavouriteTableViewCell)

var article: Article? = (item as? Article)

var title = ()

var row = ()

var row = ()

var strongSelf: __typeof__(__weakSelf)? = __weakSelf


func loadArticlesFromWebservice() {
    self.loader.loadAsynchronously(self.configuration, callback: {(_ result: Any) -> Void in
        if (result is [Any]) {
            self.articlesRepository.storeArticlesTemporarily(result)
            self.dataSource.addItems(result)
            // reloads table view on main queue
        }
    })
}

override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 100.0
}

override func tableView(_ tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    var article: Article? = self.dataSource.item(at: indexPath)
    if !article?.thumbnailData {
        var favouriteCell: FavouriteTableViewCell?
        var tag: Int = indexPath.row
        if (cell is FavouriteTableViewCell) {
            favouriteCell = (cell as? FavouriteTableViewCell)
        }
        var configuration = AsyncLoadConfiguration.from(article)
        self.loader.loadAsynchronously(configuration, callback: {(_ result: Any) -> Void in
            if (result is Data) {
                article?.thumbnailData = result
                DispatchQueue.main.async(execute: {() -> Void in
                    if favouriteCell?.tag == tag {
                        favouriteCell?.imageView?.image = article?.imageFromThumbnailData()
                        favouriteCell?.setNeedsDisplay()
                    }
                })
            }
        })
    }
}

override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    var article: Article? = self.dataSource.item(at: indexPath)
    var favourite: Bool = self.articlesRepository.isFavouriteArticle(article)
    var viewController = Configurator.configuredDetailsViewController(with: article, favourite: favourite)
    self.showViewController(viewController, sender: self)
}

func favouriteButtonTapped(_ sender: UIButton) {
    var indexPath = IndexPath(row: sender.tag, section: 0)
    var article: Article? = self.dataSource.item(at: indexPath)
    if self.articlesRepository.isFavouriteArticle(article) {
        self.articlesRepository.removeFavouriteArticle(article)
    }
    else {
        self.articlesRepository.saveFavouriteArticle(article)
    }
    sender.selected = !sender.selected
    sender.setNeedsDisplay()
}

func rightBarButtonItemTapped(_ sender: UIBarButtonItem) {
    self.isFilterEnabled = !self.isFilterEnabled
    sender.title = (self.isFilterEnabled) ? kAll : kFavourite
    if self.isFilterEnabled {
        self.dataSource.setItems(self.articlesRepository.savedFavouritesArticles())
    }
    else {
        self.dataSource.setItems(self.articlesRepository.temporarilyStoredArticles())
    }
}