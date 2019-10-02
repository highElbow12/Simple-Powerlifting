//
//  BarbellCalculator .swift
//  Simple Powerlifting
//
//  Created by Sungjea Cho on 5/25/17.
//  Copyright © 2017 chillmo. All rights reserved.
//

import Foundation


class BarbellCalculator {
    
    var array: [Int]
    
    init(){
        array = [Int]()
    }
    

   
    
    func fillArray(weight: Double){
        
        let weight2 = (weight-45)/2
        
        let q45 = (Int)(weight2/45)
        array.append(q45)
        let r45 = weight2.truncatingRemainder(dividingBy: 45)
        
        let q35 = (Int)(r45/35)
        array.append(q35)
        let r35 = r45.truncatingRemainder(dividingBy: 35)
        
        let q25 = (Int)(r35/25)
        array.append(q25)
        let r25 = r35.truncatingRemainder(dividingBy: 25)
        
        let q10 = (Int)(r25/10)
        array.append(q10)
        let r10 = r25.truncatingRemainder(dividingBy: 10)
        
        let q5 = (Int)(r10/5)
        array.append(q5)
        let r5 = r10.truncatingRemainder(dividingBy: 5)
        
        let q2 = (Int)(r5/2.5)
        array.append(q2)
        
        
        
        
        
        
        
    }
    
    
    
}
