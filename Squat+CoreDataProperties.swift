//
//  Squat+CoreDataProperties.swift
//  Simple Powerlifting
//
//  Created by Sungjea Cho on 3/30/17.
//  Copyright © 2017 chillmo. All rights reserved.
//

import Foundation
import CoreData


extension Squat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Squat> {
        return NSFetchRequest<Squat>(entityName: "Squat");
    }

    @NSManaged public var weight: Double

}
