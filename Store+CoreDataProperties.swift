//
//  Store+CoreDataProperties.swift
//  DreamLister
//
//  Created by Junaid Khan on 23/04/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation
import CoreData


extension Store {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Store> {
        return NSFetchRequest<Store>(entityName: "Store");
    }

    @NSManaged public var name: String?
    @NSManaged public var toItem: NSSet?
    @NSManaged public var toImages: Image?

}

// MARK: Generated accessors for toItem
extension Store {

    @objc(addToItemObject:)
    @NSManaged public func addToToItem(_ value: Items)

    @objc(removeToItemObject:)
    @NSManaged public func removeFromToItem(_ value: Items)

    @objc(addToItem:)
    @NSManaged public func addToToItem(_ values: NSSet)

    @objc(removeToItem:)
    @NSManaged public func removeFromToItem(_ values: NSSet)

}
