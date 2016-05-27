//
//  OperationTicketStep.swift
//  NetDemo
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import Foundation
import CoreData

class OperationTicketStep: BaseModel {
    static let talbeName = "om_ck_optstep"

    @NSManaged var stepid: String
    @NSManaged var optid: String
    @NSManaged var code: NSNumber
    @NSManaged var description2: String
    @NSManaged var isruned: String
    @NSManaged var finishtime: NSDate

}
