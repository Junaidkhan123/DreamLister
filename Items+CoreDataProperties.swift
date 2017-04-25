//
//  Items+CoreDataProperties.swift
//  DreamLister
//
//  Created by Junaid Khan on 23/04/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation
import CoreData


extension Items {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Items> {
        return NSFetchRequest<Items>(entityName: "Items");
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var details: String?
    @NSManaged public var price: Double
    @NSManaged public var title: String?
    @NSManaged public var toImage: Image?
    @NSManaged public var toStore: Store?
    @NSManaged public var toItemType: ItemType?

}
