//  Converted with Swiftify v1.0.6221 - https://objectivec2swift.com/
//
//  FavouriteTableViewCell.h
//  GoT
//
//  Created by piotrom1 on 26/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
import UIKit
class FavouriteTableViewCell: UITableViewCell {
    var titleLabel: UILabel! {
        return self.privateTitleLabel
    }
    var abstractLabel: UILabel! {
        return self.privateAbstractLabel
    }
    var favouriteButton: UIButton! {
        return self.privateFavouriteButton
    }


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        self.imageView?.image = FavouriteTableViewCell.avatarImage()
        self.privateTitleLabel = UILabel.autolayout()
        self.privateAbstractLabel = UILabel.autolayout()
        self.privateAbstractLabel.numberOfLines = 2
        self.privateFavouriteButton = UIButton.autolayout()
        self.privateFavouriteButton.setImage(FavouriteTableViewCell.favouriteOffImage(), for: .normal)
        self.privateFavouriteButton.setImage(FavouriteTableViewCell.favouriteOnImage(), for: .selected)
        self.contentView.addSubview(self.privateTitleLabel)
        self.contentView.addSubview(self.privateAbstractLabel)
        self.contentView.addSubview(self.privateFavouriteButton)
        self.privateTitleLabel.mas_makeConstraints({(_ make: MASConstraintMaker) -> Void in
            make.left.equalTo(self.imageView?.mas_right)?.offset(10)
            make.right.equalTo(self.privateFavouriteButton.mas_left).offset(-10)
            make.top.equalTo(self.privateTitleLabel.superview?).offset(10)
        })
        self.privateAbstractLabel.mas_makeConstraints({(_ make: MASConstraintMaker) -> Void in
            make.top.equalTo(self.privateTitleLabel.mas_bottom).offset(10)
            make.left.right.equalTo(self.privateTitleLabel)
            make.bottom.equalTo(self.contentView).offset(-10)
        })
        self.privateFavouriteButton.mas_makeConstraints({(_ make: MASConstraintMaker) -> Void in
            make.width.and.height.equalTo(40)
            make.right.equalTo(self.privateFavouriteButton.superview?).offset(-10)
            make.centerY.equalTo(self.privateFavouriteButton.superview)
        })
    
    }

    class func avatarImage() -> UIImage {
        var avatarImage: UIImage?
        var onceToken: dispatch_once_t
        dispatch_once(onceToken, {() -> Void in
            avatarImage = UIImage(named: "avatar")
        })
        return avatarImage!
    }

    class func favouriteOnImage() -> UIImage {
        var image: UIImage?
        var onceToken: dispatch_once_t
        dispatch_once(onceToken, {() -> Void in
            image = UIImage(named: "fav_on")
        })
        return image!
    }

    class func favouriteOffImage() -> UIImage {
        var image: UIImage?
        var onceToken: dispatch_once_t
        dispatch_once(onceToken, {() -> Void in
            image = UIImage(named: "fav_off")
        })
        return image!
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView?.image = FavouriteTableViewCell.avatarImage()
        self.textLabel?.text = ""
        self.detailTextLabel?.text = ""
        self.titleLabel?.text = ""
        self.abstractLabel.text = ""
        self.privateFavouriteButton.selected = false
    }

    var privateTitleLabel: UILabel!
    var privateAbstractLabel: UILabel!
    var privateFavouriteButton: UIButton!
}
//
//  FavouriteTableViewCell.m
//  GoT
//
//  Created by piotrom1 on 26/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
import Masonry