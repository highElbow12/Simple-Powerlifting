//
//  Squat+CoreDataClass.swift
//  Simple Powerlifting
//
//  Created by Sungjea Cho on 3/30/17.
//  Copyright © 2017 chillmo. All rights reserved.
//

import Foundation
import CoreData


public class Squat: NSManagedObject {
    
    convenience init(weight: Double, context: NSManagedObjectContext) {
        
        // An EntityDescription is an object that has access to all
        // the information you provided in the Entity part of the model
        // you need it to create an instance of this class.
        if let ent = NSEntityDescription.entity(forEntityName: "Squat", in: context) {
            self.init(entity: ent, insertInto: context)
            self.weight = weight
            
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
    

}
