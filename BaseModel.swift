//
//  BaseModel.swift
//  NetDemo
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import Foundation
import CoreData

class BaseModel: NSManagedObject {
    
    @NSManaged var kpchangedate: NSNumber
    @NSManaged var isChanged: NSNumber
    @NSManaged var conflictId: String
    @NSManaged var flowname: String
    
}
