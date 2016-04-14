//
//  Youtube.swift
//  AcknowledgeApp
//
//  Created by Fhict on 13/04/16.
//  Copyright © 2016 Gregory Lammers. All rights reserved.
//

import UIKit

class Youtube: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var WebViewYouTube: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = NSURL(string: "https://www.youtube.com/user/AcknowledgeChannel")!
        
        WebViewYouTube.loadRequest(NSURLRequest(URL: url))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
