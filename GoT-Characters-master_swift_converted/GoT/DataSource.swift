//  Converted with Swiftify v1.0.6221 - https://objectivec2swift.com/
//
//  DataSource.h
//  GoT
//
//  Created by piotrom1 on 26/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
import UIKit
typealias CellConfigureBlock = (_ cell: UITableViewCell, _ indexPath: IndexPath, _ item: Any) -> Void
class DataSource: NSObject, UITableViewDataSource {
    weak var tableView: UITableView?
    var cellReuseIdentifier: String {
        return self.reuseIdentifier
    }
    var cellConfigureBlock: CellConfigureBlock?

    override init(cellConfigureBlock configureBlock: CellConfigureBlock?, cellReuseIdentifier reuseIdentifier: String) {
        super.init()
        
        self.cellConfigureBlock = configureBlock
        self.reuseIdentifier = reuseIdentifier
        self.mutableItems = [Any]()
    
    }

    override func addItems(_ items: [Any]) {
        self.mutableItems += items
        NSMutableArray(array: self.mutableItems).sortUsingDescriptors([NSSortDescriptor(key: "title", ascending: true)])
        // Hack for sorting Articles by their title. Crash if anything other than
        // Article stored as item. Solution: use objc generics and protocol -
        // func keyForSorting -> String
        if self.tableView {
            DispatchQueue.main.async(execute: {() -> Void in
                self.tableView.reloadData()
            })
        }
    }
    // reloads tableView on main queue

    func setItems(_ items: [Any]) {
        self.mutableItems.removeAll()
        self.addItems(items)
    }
    // reloads tableView on main queue

    func item(at indexPath: IndexPath) -> Any? {
        var item: Any?
        var index: Int = indexPath.row
        if index < self.mutableItems.count {
            item = self.mutableItems[index]
        }
        return item
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mutableItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath)
        var item: Any? = self.item(at: indexPath)
        if item != nil {
            self.cellConfigureBlock(cell, indexPath, item)
        }
        return cell!
    }

    var reuseIdentifier: String = ""
    var mutableItems = [Any]()
}
//
//  DataSource.m
//  GoT
//
//  Created by piotrom1 on 26/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//