//
//  MotivationView.swift
//  Simple Powerlifting
//
//  Created by Sungjea Cho on 5/14/17.
//  Copyright © 2017 chillmo. All rights reserved.
//

import Foundation
import UIKit


class MotivationView : UIViewController {
    
   
    
    var urlString:String?
    
    
   
    @IBAction func refresh(_ sender: Any){
        
        YoutubeClient.performGETRequest { url in
            
            guard url != nil else {
                print("no url found")
                return
            }
            self.urlString = url
            let url = URL(string: self.urlString!)!
            let request = URLRequest(url: url)
            self.webView.loadRequest(request)
            
            
        }
        
     
        
    }
    
    @IBOutlet weak var webView: UIWebView!
    
    
    
}
