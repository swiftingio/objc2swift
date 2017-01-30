//  Converted with Swiftify v1.0.6221 - https://objectivec2swift.com/
//
//  UIView+Additions.h
//  ParallaxDemo
//
//  Created by Paciej on 18/10/15.
//  Copyright (c) 2015 Paciej. All rights reserved.
//
import UIKit
extension UIView {
    /** Creates constraints from array of visual format language strings and adds
     * them to the view*/
    class func addConstraints(fromStrings strings: [Any], withMetrics metrics: [AnyHashable: Any], andViews views: [AnyHashable: Any], to view: UIView) {
        var constraints = [Any]()
        for string: String in strings {
            constraints += NSLayoutConstraint.constraints(withVisualFormat: string, options: [], metrics: metrics, views: views)
        }
        view.addConstraints(constraints)
    }
    /** Creates view ready-to-use with auto layout */

    class func autolayout() -> Self {
        var view: UIView? = self.self(frame: CGRect.zero)
        view?.translatesAutoresizingMaskIntoConstraints = false
        return view!
    }


    class func addEdgeConstraint(_ edge: NSLayoutAttribute, superview: UIView, subview: UIView) {
        superview.addConstraint(NSLayoutConstraint(item: subview, attribute: edge, relatedBy: .equal, toItem: superview, attribute: edge, multiplier: 1, constant: 0))
    }
}
//
//  UIView+Additions.m
//  ParallaxDemo
//
//  Created by Paciej on 18/10/15.
//  Copyright (c) 2015 Paciej. All rights reserved.
//