//
//  TDNetS.swift
//  TDNetS
//
//  Created by Adrian Johnson on 03/04/2017.
//  Copyright © 2017 Training Dragon. All rights reserved.
//

import Foundation
public struct TDNetS {
    
    public init() {
        
    }
    
    static func applicationDocumentsDirectory() -> URL? {
        return URL.applicationDocumentsDirectory()
    }
    
    public func doGETArray(url: String?, headers: Dictionary<String,String>?, responseCallback: @escaping (Array<Dictionary<String,Any>>?, Error?) -> Void) {
        if Reachability.isConnectedToNetwork() {
            if let url = url {
                let link = URL(string: url)
                link?.get(headers: headers, callback: { (responseData: Data?, error: Error?) in
                    let array = responseData?.toArray()
                    responseCallback(array as? Array<Dictionary<String, Any>>, error)
                })
            }
        } else {
            responseCallback(nil, Reachability.getUnconnectedError())
        }
    }
    
    func doGETDictionary(url: String?, headers: Dictionary<String,String>?, responseCallback: @escaping (Dictionary<String,Any>?, Error?) -> Void) {
        if Reachability.isConnectedToNetwork() {
            if let url = url {
                let link = URL(string: url)
                link?.get(headers: headers, callback: { (responseData: Data?, error: Error?) in
                    let dictionary = responseData?.toDictionary()
                    responseCallback(dictionary, error)
                })
            }
        } else {
            responseCallback(nil, Reachability.getUnconnectedError())
        }
    }
    
    func doGET(url: String?, headers: Dictionary<String,String>?, callback:@escaping (Data?, Error?) -> Void) {
        if Reachability.isConnectedToNetwork() {
            if let url = url {
                let link = URL(string: url)
                link?.get(headers: headers, callback: { (responseData: Data?, error: Error?) in
                    callback(responseData, error)
                })
            }
        } else {
            callback(nil, Reachability.getUnconnectedError())
        }
    }
    
    func get(url: String?, headers: Dictionary<String,String>?, callback:@escaping (Data?, Error?) -> Void) {
        if Reachability.isConnectedToNetwork() {
            if let url = url {
                let link = URL(string: url)
                link?.get(headers: headers, callback: { (responseData: Data?, error: Error?) in
                    callback(responseData, error)
                })
            }
        } else {
            callback(nil, Reachability.getUnconnectedError())
        }
    }
    
    func doPOST(url: String?, headers: Dictionary<String,String>?, data: Dictionary<String,Any>?, callback: @escaping (Data?, Error?) -> Void) {
        if Reachability.isConnectedToNetwork() {
            if let url = url {
                let link = URL(string: url)
                link?.post(headers: headers, data: data, callback: { (responseData: Data?, error: Error?) in
                    callback(responseData, error)
                })
            }
        } else {
            callback(nil, Reachability.getUnconnectedError())
        }
    }
    
    func post(url: String?, data: Data?, callback: @escaping (Data?, Error?) -> Void) {
        if Reachability.isConnectedToNetwork() {
            if let url = url {
                let link = URL(string: url)
                if let data = data {
                    link?.post(data: data, callback: { (responseData: Data?, error: Error?) in
                        callback(responseData, error)
                    })
                }
            }
        } else {
            callback(nil, Reachability.getUnconnectedError())
        }
    }
}
