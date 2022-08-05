//
//  SingleFamily+CoreDataProperties.swift
//  HomeReport
//
//  Created by Apple on 05.08.2022.
//
//

import Foundation
import CoreData


extension SingleFamily {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SingleFamily> {
        return NSFetchRequest<SingleFamily>(entityName: "SingleFamily")
    }

    @NSManaged public var lotSize: Int16

}
