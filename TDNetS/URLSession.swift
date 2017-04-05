//
//  URLSession.swift
//  TDNetS
//
//  Created by Adrian Johnson on 03/04/2017.
//  Copyright © 2017 Training Dragon. All rights reserved.
//

import Foundation
extension URLSession {
    
    func dataFromURL(url: String) -> URLSessionDataTask? {
        var task: URLSessionDataTask?
        if let dataURL = URL(string: url){
            task = dataTask(with: dataURL)
            task?.resume()
        }
        return task
    }

    
    func dataFromURL(url: URL, headers: Dictionary<String,String>) -> URLSessionDataTask? {
        let request = self.request(url: url, headers: headers)
        let task = self.dataTask(with: request)
        task.resume()
        return task
    }
    
    func download(url: String) -> URLSessionDownloadTask? {
        var task: URLSessionDownloadTask? = nil
        if let downloadURL = URL(string: url) {
            task = self.downloadTask(with: downloadURL)
            task?.resume()
        }
        return task
    }
    
    func download(url: String, headers: Dictionary<String,String>) -> URLSessionDownloadTask? {
        var task: URLSessionDownloadTask? = nil
        if let downloadURL = URL(string: url) {
        let request = self.request(url: downloadURL, headers: headers)
            task = self.downloadTask(with: request)
            task?.resume()
        }
        return task
    }
    
    func request(url: URL, headers: Dictionary<String,String>) -> URLRequest {
        let request = NSMutableURLRequest(url: url)
        for (key,value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        return request as URLRequest
    }
}
