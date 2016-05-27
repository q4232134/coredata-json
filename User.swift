//
//  User.swift
//  NetDemo
//
//  Created by apple on 15/9/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import Foundation
import CoreData

class User: BaseModel {
    static let talbeName = "sys_user"
    @NSManaged var createby: String
    @NSManaged var createdate: NSDate
    @NSManaged var deptnum: String
    @NSManaged var displayname: String
    @NSManaged var email: String
    @NSManaged var employeenum: String
    @NSManaged var image: String
    @NSManaged var isvalid: String
    @NSManaged var loginid: String
    @NSManaged var mlnid: NSNumber
    @NSManaged var modifyby: String
    @NSManaged var modifydate: NSDate
    @NSManaged var orgid: String
    @NSManaged var password: String
    @NSManaged var ptlspecialty: String
    @NSManaged var remark: String
    @NSManaged var userid: String

}
