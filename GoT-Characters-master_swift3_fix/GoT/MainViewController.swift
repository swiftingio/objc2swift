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
    init(loader: Loader, asyncLoadConfiguration configuration: AsyncLoadConfiguration, dataSource: DataSource, articlesRepository: ArticlesRepository) {
        self.isFilterEnabled = false
        super.init(nibName: nil, bundle: nil)
        
        self.loader = loader
        self.configuration = configuration
        self.dataSource = dataSource
        self.articlesRepository = articlesRepository
        self.title = "Characters"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: kFavourite, style: .plain, target: self, action: #selector(self.rightBarButtonItemTapped))
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTableView()
        self.loadArticlesFromWebservice()
    }

    func loadTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.register(FavouriteTableViewCell.self, forCellReuseIdentifier: dataSource.cellReuseIdentifier)
        view.addSubview(tableView)
        tableView.mas_makeConstraints { (_ make: MASConstraintMaker?) in
            _ = make?.edges.equalTo()(self.tableView.superview)
        }
        dataSource.tableView = tableView
        dataSource.cellConfigureBlock = { [weak self](cell: UITableViewCell, indexPath: IndexPath, item: Article) in
            guard let strongSelf = self else { return }
            let favCell: FavouriteTableViewCell = cell as? FavouriteTableViewCell ?? FavouriteTableViewCell()
            favCell.titleLabel.text = item.title
            favCell.abstractLabel.text = item.abstract
            favCell.tag = indexPath.row
            favCell.favouriteButton.tag = indexPath.row
            if item.thumbnailData != nil {
                favCell.imageView?.image = item.imageFromThumbnailData()
            }
            favCell.favouriteButton.addTarget(strongSelf, action: #selector(strongSelf.favouriteButtonTapped), for: .touchUpInside)
            favCell.favouriteButton.isSelected = strongSelf.articlesRepository.isFavouriteArticle(item)
        }
    }

    var loader: Loader!
    var configuration: AsyncLoadConfiguration!
    var dataSource: DataSource!
    var articlesRepository: ArticlesRepository!
    var tableView: UITableView!
    var isFilterEnabled: Bool
    
    func loadArticlesFromWebservice() {
        self.loader.loadAsynchronously(self.configuration, callback: {[weak self](_ result: Any?) -> Void in
            if let articles = result as? [Article] {
                self?.articlesRepository.storeArticlesTemporarily(articles)
                self?.dataSource.addItems(articles)
                // reloads table view on main queue
            }
        })
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    @objc(tableView:willDisplayCell:forRowAtIndexPath:) func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let article = self.dataSource.item(at: indexPath) else {
            return
        }
        if article.thumbnailData == nil {
            var favouriteCell: FavouriteTableViewCell?
            let tag: Int = indexPath.row
            if (cell is FavouriteTableViewCell) {
                favouriteCell = (cell as? FavouriteTableViewCell)
            }
            let configuration = AsyncLoadConfiguration.from(article)
            self.loader.loadAsynchronously(configuration, callback: {(_ result: Any?) -> Void in
                if let data = result as? Data  {
                    article.thumbnailData = data
                    DispatchQueue.main.async(execute: {() -> Void in
                        if favouriteCell?.tag == tag {
                            favouriteCell?.imageView?.image = article.imageFromThumbnailData()
                            favouriteCell?.setNeedsDisplay()
                        }
                    })
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let article = self.dataSource.item(at: indexPath) else { return }
        let favourite: Bool = self.articlesRepository.isFavouriteArticle(article)
        let viewController = Configurator.configuredDetailsViewController(with: article, favourite: favourite)
        //self.showViewController(viewController, sender: self)
        self.show(viewController, sender: self)
    }
    
    func favouriteButtonTapped(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        guard let article = self.dataSource.item(at: indexPath) else { return }
        if self.articlesRepository.isFavouriteArticle(article) {
            self.articlesRepository.removeFavouriteArticle(article)
        }
        else {
            self.articlesRepository.saveFavouriteArticle(article)
        }
        //sender.selected = !sender.selected
        sender.isSelected = !sender.isSelected
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
}
//
//  MainViewController.m
//  GoT
//
//  Created by Paciej on 21/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
var kFavourite: String = "Favourite"

var kAll: String = "All"

//var dataSource = ()
//
//var self = ()
//
//var tableView = ()
//
//weak var __weakSelf: __typeof__(self)? = self
//
//var favCell: FavouriteTableViewCell? = (cell as? FavouriteTableViewCell)
//
//var article: Article? = (item as? Article)
//
//var title = ()
//
//var row = ()
//
//var row = ()
//
//var strongSelf: __typeof__(__weakSelf)? = __weakSelf
