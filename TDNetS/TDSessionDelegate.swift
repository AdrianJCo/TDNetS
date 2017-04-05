//
//  TDSessionDelegate.swift
//  TDNetS
//
//  Created by Adrian Johnson on 03/04/2017.
//  Copyright © 2017 Training Dragon. All rights reserved.
//

import Foundation
class TDSessionDelegate : NSObject, URLSessionDelegate, URLSessionDownloadDelegate, URLSessionDataDelegate {
    
    var data: NSMutableData?
    var callback: ((Data?, Error?) -> Void)?
    
    override init() {
        
        super.init()
    }
    //delegate
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        NSLog("didCompleteWithError")
        if let callback = self.callback {
            callback(data as Data?, error)
        }
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        NSLog("didBecomeInvalidWithError")
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        NSLog("didReceiveChallenge")
        let cred = URLCredential(user: "admin", password: "admin", persistence: .none)
        completionHandler(.useCredential, cred)
    }
    
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        NSLog("URLSessionDidFinishEventsForBackgroundURLSession")
    }
    
    //download delegate
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        NSLog("didFinishDownloadingToURL");
        let destinationURL = String(format: "%@%@", URL.applicationDocumentsDirectory()! as CVarArg, downloadTask.taskDescription!)
        NSLog("TD: %@",destinationURL)
        
        let fileManager = FileManager.default
        if let url = URL(string: destinationURL) {
        do {
            try fileManager.removeItem(at:url)
            try fileManager.copyItem(at:location, to:url)
        } catch {
            NSLog("Could not copy file to disk: %@",error.localizedDescription)
        }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        NSLog("didResumeAtOffset")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        NSLog("didWriteData")
    }
    
    //data delegate
    
    /**
     * During upload of the body data (if your app provides any), the session periodically calls its delegate’s URLSession:task:didSendBodyData:totalBytesSent:totalBytesExpectedToSend: method with status information.
     */
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        NSLog("didSendBodyData")
    }
    
    /**
     * After receiving an initial response, the session calls its delegate’s URLSession:dataTask:didReceiveResponse:completionHandler: method to let you examine the status code and headers, and optionally convert the data task into a download task.
     */
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        let httpResponse = response as! HTTPURLResponse
        NSLog("didReceiveResponse %ld", httpResponse.statusCode)
        data = NSMutableData()
        completionHandler(.allow)
    }
    
    /**
     * During the transfer, the session calls its delegate’s URLSession:dataTask:didReceiveData: method to provide your app with the content as it arrives.
     */
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        NSLog("didReceiveData")
        self.data?.append(data)
    }
}
