//  Converted with Swiftify v1.0.6221 - https://objectivec2swift.com/
//
//  NSData+JSON.h
//  GoT
//
//  Created by Paciej on 24/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
import Foundation
extension NSData {
    private(set) var jsonObject: Any!


    func jsonObject() -> Any {
        do {
            return try JSONSerialization.jsonObject(withData: self, options: NSJSONReadingAllowFragments)!
        }
        catch {
        }
    }
}
//
//  NSData+JSON.m
//  GoT
//
//  Created by Paciej on 24/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//