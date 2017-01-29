//  Converted with Swiftify v1.0.6221 - https://objectivec2swift.com/
//
//  DetailsViewController.h
//  GoT
//
//  Created by Paciej on 21/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
import UIKit
class DetailsViewController: UIViewController {
    init(article: Article, favourite: Bool) {
        super.init(nibName: nil, bundle: nil)
        
        self.article = article
        self.title = article.title
        self.view.backgroundColor = UIColor.white
        self.imageView = UIImageView(autolayout: true)
        self.imageView?.image = article.imageFromThumbnailData()
        self.abstractTextView = UITextView(autolayout: true)
        // self.abstractTextView.editable = false
        self.abstractTextView.isEditable = false
        self.abstractTextView.text = article.abstract
        self.abstractTextView.font = UIFont.systemFont(ofSize: CGFloat(UIFont.systemFontSize))
        self.favouriteInfoLabel = UILabel(autolayout: true)
        self.favouriteInfoLabel.text = favourite ? "This is your favourite article" : "This is not your favourite article"
        self.favouriteInfoLabel.textAlignment = .center
        self.favouriteInfoLabel.font = UIFont.systemFont(ofSize: CGFloat(UIFont.systemFontSize))
        self.openButton = UIButton(autolayout: true)
        self.openButton.setTitle("Open in Safari", for: .normal)
        self.openButton.addTarget(self, action: #selector(self.openButtonTapped), for: .touchUpInside)
        self.openButton.setTitleColor(UIColor.gray, for: .normal)
        self.openButton.setTitleColor(UIColor.lightGray, for: .highlighted)
        self.view.addSubview(self.imageView)
        self.view.addSubview(self.abstractTextView)
        self.view.addSubview(self.openButton)
        self.view.addSubview(self.favouriteInfoLabel)
       
        _ = self.imageView?.mas_makeConstraints({(make: MASConstraintMaker?) -> Void in
            _ = make?.centerX.equalTo()(self.imageView?.superview)
            _ = make?.top.equalTo()(self.imageView?.superview)?.offset()(10)
            _ = make?.width.height().equalTo()(100)
        })
        self.abstractTextView.mas_makeConstraints({(make: MASConstraintMaker?) -> Void in
            _ = make?.top.equalTo()(self.imageView?.mas_bottom)?.offset()(10)
            _ = make?.left.equalTo()(self.abstractTextView.superview)?.offset()(10)
            _ = make?.right.equalTo()(self.abstractTextView.superview)?.offset()(-10)
            _ = make?.bottom.equalTo()(self.favouriteInfoLabel.mas_top)?.offset()(-10)
        })
        self.favouriteInfoLabel.mas_makeConstraints({(make: MASConstraintMaker?) -> Void in
            _ = make?.height.equalTo()(40)
            _ = make?.bottom.equalTo()(self.openButton.mas_top)?.offset()(10)
            _ = make?.left.right().equalTo()(self.abstractTextView)
        })
        self.openButton.mas_makeConstraints({(make: MASConstraintMaker?) -> Void in
            _ = make?.height.equalTo()(40)
            _ = make?.left.right().equalTo()(self.abstractTextView)
            _ = make?.bottom.equalTo()(self.openButton.superview)?.offset()(-10)
        })
        self.edgesForExtendedLayout = []
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func openButtonTapped(_ sender: UIButton) {
        guard let url = URL(string: self.article.urlString) else { return }
        UIApplication.shared.openURL(url)
    }

    var article: Article!
    var imageView: UIImageView!
    var abstractTextView: UITextView!
    var openButton: UIButton!
    var favouriteInfoLabel: UILabel!
}
//
//  DetailsViewController.m
//  GoT
//
//  Created by Paciej on 21/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
/*Detail view is meant to display all above information about the selected Wiki
 * and enable the user to go to that wiki article in Safari using a button. User
 * should also see if a wiki is added to his favorite list or not.
 title
 thumbnail
 abstract - shortened to max 2 lines of description
 */
