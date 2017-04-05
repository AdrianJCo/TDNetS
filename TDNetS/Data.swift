//
//  Data.swift
//  TDNetS
//
//  Created by Adrian Johnson on 03/04/2017.
//  Copyright © 2017 Training Dragon. All rights reserved.
//

import Foundation
extension Data {
    
    func toDictionary() -> Dictionary<String,Any>? {
        let result: Any
        do {
            result = try JSONSerialization.jsonObject(with: self, options: .init(rawValue: 0))
        } catch {
            return nil
        }
        return result as? Dictionary<String,Any>
    }
    
    func toArray() -> Array<Any>? {
        let result: Any
        do {
            result = try JSONSerialization.jsonObject(with: self, options: .init(rawValue: 0))
        } catch {
            return nil
        }
        return result as? Array<Any>
    }
}
