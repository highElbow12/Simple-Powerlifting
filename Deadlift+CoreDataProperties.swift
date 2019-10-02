//
//  Deadlift+CoreDataProperties.swift
//  Simple Powerlifting
//
//  Created by Sungjea Cho on 3/30/17.
//  Copyright © 2017 chillmo. All rights reserved.
//

import Foundation
import CoreData


extension Deadlift {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Deadlift> {
        return NSFetchRequest<Deadlift>(entityName: "Deadlift");
    }

    @NSManaged public var weight: Double

}
