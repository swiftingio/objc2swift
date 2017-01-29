//  Converted with Swiftify v1.0.6221 - https://objectivec2swift.com/
//
//  NSData+JSON.h
//  GoT
//
//  Created by Paciej on 24/10/15.
//  Copyright © 2015 Maciej Piotrowski. All rights reserved.
//
import Foundation
extension Data {
    func jsonObject() -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .allowFragments)
        }
        catch {
            return nil
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
