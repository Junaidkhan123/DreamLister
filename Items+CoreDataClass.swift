//
//  Items+CoreDataClass.swift
//  DreamLister
//
//  Created by Junaid Khan on 23/04/2017.
//  Copyright © 2017 mac. All rights reserved.
//

import Foundation
import CoreData

@objc(Items)
public class Items: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created = NSDate()
    }
    

}
