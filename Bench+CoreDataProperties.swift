//
//  Bench+CoreDataProperties.swift
//  Simple Powerlifting
//
//  Created by Sungjea Cho on 3/30/17.
//  Copyright © 2017 chillmo. All rights reserved.
//

import Foundation
import CoreData


extension Bench {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bench> {
        return NSFetchRequest<Bench>(entityName: "Bench");
    }

    @NSManaged public var weight: Double

}
