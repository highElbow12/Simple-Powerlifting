//
//  YoutubeClient.swift
//  Simple Powerlifting
//
//  Created by Sungjea Cho on 5/14/17.
//  Copyright © 2017 chillmo. All rights reserved.
//

import Foundation
import UIKit

class YoutubeClient: NSObject {
    
   
    
    
    class func performGETRequest(completionHandler : @escaping (_ url: String?) -> Void){
        
        let session = URLSession.shared
        let url = URL(string: YoutubeClient.Constants.url)
        let request = URLRequest(url: url! as URL)
        var playURL = ""
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard (error == nil) else {
                print(error as! String)
                return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                print("Your request returned a status code other than 2xx!")
                return
            }
            
            guard let data = data else {
                print("No data was returned by the request!")
                return
            }
            
            // parse the data
            let parsedResult: AnyObject!
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            } catch {
                print("Could not parse the data as JSON: '\(data)'")
                return
            }
            
            guard let items = parsedResult["items"] as? [AnyObject] else{
                print("Could not find items")
                return
                
            }
            
            let randomVideoIndex = Int(arc4random_uniform(UInt32(items.count)))
            
            guard let randomVideo = items[randomVideoIndex] as? [String : AnyObject] else{
                print("no random video found")
                return
            }
            
            guard let id = randomVideo["id"] as? [String : String] else{
                print("no id found")
                return
            }
            
            guard let videoID = id["videoId"] else{
                print("no videoId found")
                return
            }
            
            
            
            playURL = YoutubeClient.Constants.embedUrl + videoID
            print(playURL) // just a checkpoint
            completionHandler(playURL)
        
            
            
        }
        task.resume()
        
     
       
        
    }
   
    
    
}
