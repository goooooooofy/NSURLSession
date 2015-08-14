//
//  ViewController.swift
//  NSURLSession下载任务
//
//  Created by goofygao on 8/13/15.
//  Copyright (c) 2015 goofygao. All rights reserved.
//

import UIKit

class ViewController: UIViewController,NSURLSessionDownloadDelegate {

    @IBOutlet weak var progress: UIProgressView!
    var downTask = NSURLSessionDownloadTask()
    var session:NSURLSession!
    //保存下载的数据
    var downData:NSData!
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL(string: "http://dlsw.baidu.com/sw-search-sp/soft/e5/13808/VMware-workstation-full-11.1.2.61471.1437365244.exe")
        
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfig.timeoutIntervalForRequest = 30
        session = NSURLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        downTask = session.downloadTaskWithURL(url!)
        downTask.resume()
    
    
    }
    
    
    

    @IBAction func conDow(sender: UIButton) {
        if let resumeData = self.downData {
       downTask = session.downloadTaskWithResumeData(resumeData)
        }
        downTask.resume()
    }
    @IBAction func pause(sender: UIButton) {
        downTask.cancelByProducingResumeData { (_resumeData:NSData!) -> Void in
            if((_resumeData) == nil) {
                return
            }
            self.downData = _resumeData
        }
        downTask.cancel()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        //下载完成之后调用方法
    }
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        var precent:Double = Double(totalBytesWritten)/Double(totalBytesExpectedToWrite)
        println("\(precent)")
    }


}

