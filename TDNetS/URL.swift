//
//  URL.swift
//  TDNetS
//
//  Created by Adrian Johnson on 03/04/2017.
//  Copyright © 2017 Training Dragon. All rights reserved.
//

import Foundation

extension URL {
    static func applicationDocumentsDirectory() -> URL? {
    // The directory the application uses to store the Core Data store file. This code vars a directory named "com.trainingdragon.DB2" in the application's documents directory.
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
    }
    
    func get(headers: Dictionary<String,String>?, callback: @escaping (Data?, Error?) -> Void) {
    
        let session = TDSession.defaultInstance()
        let mydelegate = session.delegate as! TDSessionDelegate
        mydelegate.callback = callback;
        if let headers = headers {
            session.dataFromURL(url: self, headers: headers)?.resume()
        }
    }
    
    func doHead(headers: Dictionary<String,String>, completionHandler: @escaping (Data?,URLResponse?,Error?) -> Void) -> Void {
        let request = NSMutableURLRequest(url: self)
        for (key,value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        request.httpMethod = "GET"
        let session = TDSession.defaultInstance()
        session.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            completionHandler(data, response, error)
        }.resume()
    }
    
    func post(headers: Dictionary<String,String>?, data: Dictionary<String,Any>?, callback: @escaping (Data?,Error?) -> Void) -> Void {
        let request = NSMutableURLRequest(url: self)
        if let headers = headers {
            for (key,value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        request.httpMethod = "POST"
        do {
            if let data = data {
                let dataToSubmit = try JSONSerialization.data(withJSONObject: data, options: .init(rawValue: 0))
                request.httpBody = dataToSubmit
                self.doReq(request: request as URLRequest, data: data, callback: { (responseData: Data?, error: Error?) in
                    callback(responseData, error)
                })
            }
        } catch {
            callback(nil, nil)
        }
    }
    
    func post(data: Data, callback: @escaping (Data?,Error?) ->Void) -> Void {
        let request = NSMutableURLRequest(url: self)
        request.httpMethod = "POST"
        request.httpBody = data
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let task = session.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
            callback(data, error)
        }
        task.resume()
    }
    
    func convertToDictionary(data: Dictionary<String,String>) -> String {
        let body = NSMutableString()
        for (key,value) in data {
            let anEntry = "\(key)=\(value),"
            body.append(anEntry)
        }
        return body.substring(to: body.length-1)
    }
    
    func doReq(request: URLRequest?, data: Dictionary<String,Any>, callback:@escaping (Data?,Error?) -> Void) -> Void {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        if let request = request {
            
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            callback(data, error)
        }
        task.resume()
        }
    }
}
