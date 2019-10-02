//
//  YoutubeConstants.swift
//  Simple Powerlifting
//
//  Created by Sungjea Cho on 5/14/17.
//  Copyright © 2017 chillmo. All rights reserved.
//

import Foundation

extension YoutubeClient {
    
    struct Constants{
        
        static let url = "https://www.googleapis.com/youtube/v3/search?key=\(apiKey)&part=snippet&q=powerlifting&maxResults=50"
        static let apiKey = "AIzaSyBdfirlOliqG6MCsV80yX3aX18ZUlmLzZQ"
        static let embedUrl = "https://www.youtube.com/embed/"
        
    }
    
    
}
