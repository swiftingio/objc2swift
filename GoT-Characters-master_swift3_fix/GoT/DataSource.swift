//  Converted with Swiftify v1.0.6221 - https://objectivec2swift.com/
//
//  DataSource.h
//  GoT
//
//  Created by piotrom1 on 26/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
import UIKit
typealias CellConfigureBlock = (_ cell: UITableViewCell, _ indexPath: IndexPath, _ item: Article) -> Void
class DataSource: NSObject, UITableViewDataSource {
    weak var tableView: UITableView?
    var cellReuseIdentifier: String {
        return self.reuseIdentifier
    }
    var cellConfigureBlock: CellConfigureBlock?

    init(cellConfigureBlock configureBlock: CellConfigureBlock?, cellReuseIdentifier reuseIdentifier: String) {
        self.cellConfigureBlock = configureBlock
        self.reuseIdentifier = reuseIdentifier
        self.mutableItems = [Article]()
        super.init()
    }

    func addItems(_ items: [Article]) {
        self.mutableItems += items
        NSMutableArray(array: self.mutableItems).sort(using: [NSSortDescriptor(key: "title", ascending: true)])
        // Hack for sorting Articles by their title. Crash if anything other than
        // Article stored as item. Solution: use objc generics and protocol -
        // func keyForSorting -> String
        if (self.tableView != nil) {
            DispatchQueue.main.async(execute: {() -> Void in
                self.tableView?.reloadData()
            })
        }
    }
    // reloads tableView on main queue

    func setItems(_ items: [Article]) {
        self.mutableItems.removeAll()
        self.addItems(items)
    }
    // reloads tableView on main queue

    func item(at indexPath: IndexPath) -> Article? {
        var item: Article?
        let index: Int = indexPath.row
        if index < self.mutableItems.count {
            item = self.mutableItems[index]
        }
        return item
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mutableItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath)
        let item: Article? = self.item(at: indexPath)
        if let item = item {
            self.cellConfigureBlock?(cell, indexPath, item)
        }
        return cell
    }

    var reuseIdentifier: String
    var mutableItems: [Article]
}
//
//  DataSource.m
//  GoT
//
//  Created by piotrom1 on 26/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
