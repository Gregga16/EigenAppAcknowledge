//
//  ViewDocument.swift
//  AcknowledgeApp
//
//  Created by Fhict on 14/04/16.
//  Copyright © 2016 Gregory Lammers. All rights reserved.
//

import UIKit

class ViewDocument: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var WebViewFile: UIWebView!
    
    var detailItem: String! {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if var detail = self.detailItem {
            
            if let webview = self.WebViewFile {
                detail = detail.stringByReplacingOccurrencesOfString(" ", withString: "%20")
                let URL = NSURL(string: detail)
                //let URL = NSURL(string: "file://".stringByAppendingString(detail))
                webview.loadRequest(NSURLRequest(URL: URL!))
                
                
                //let url = NSURL(string: "http://athena.fhict.nl/users/i254909/iOS/files/Presentatie%20Acknowledge%20Infrastructuur%20Performance%20Scan%20v1_1.pptx")
                //webview.loadRequest(NSURLRequest(URL: url!))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureView()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(webView: UIWebView){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
}
