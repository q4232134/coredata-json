//
//  SafeItems.swift
//  NetDemo
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import Foundation
import CoreData

class SafeItems: BaseModel {
    static let talbeName = "om_ck_wktmeasures"
    @NSManaged var execontent: String
    @NSManaged var executer: String
    @NSManaged var isfinished: String
    @NSManaged var measuresid: String
    @NSManaged var orderby: NSNumber
    @NSManaged var sfcontent: String
    @NSManaged var sftype: String
    @NSManaged var wktid: String

}
