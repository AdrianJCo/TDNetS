//
//  TDSession.swift
//  TDNetS
//
//  Created by Adrian Johnson on 03/04/2017.
//  Copyright © 2017 Training Dragon. All rights reserved.
//

import Foundation

class TDSession : URLSession {
    
    static func backgroundInstance() -> URLSession {
        var session: URLSession
        let config = URLSessionConfiguration.background(withIdentifier: "trainingdragon")
        let delegate = TDSessionDelegate()
        session = super.init(configuration: config, delegate: delegate, delegateQueue: OperationQueue.main)
        
        return session
    }
    
    static func defaultInstance() -> URLSession {
        var session: URLSession
    
        let config = URLSessionConfiguration.default
        let delegate = TDSessionDelegate()
        session =  super.init(configuration: config, delegate:delegate, delegateQueue: OperationQueue.main)
        return session
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return super.dataTask(with: request, completionHandler: completionHandler)
    }
}
