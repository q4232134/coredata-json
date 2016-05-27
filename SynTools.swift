//
//  SynTools.swift
//  NetDemo
//
//  Created by apple on 15/9/6.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import Foundation
import SwiftHTTP
import CoreData
import SwiftyJSON

class SynTools{
    
    static func syn(context:NSManagedObjectContext ,entityName:String){
        var ta = HTTPTask()
        ta.POST("http://192.168.1.249:8088/ptlsystem/pdc/Data/updateTable.do",parameters: [
            "_loginid":"admin",
            "_password":"123",
            "tableName":entityName,
            "kpchangedate":"0",
            "zContent":"",
            "from":"IOS"],
            completionHandler: {(response: HTTPResponse) in
                if let err = response.error {
                    println("error: \(err.localizedDescription)")
                    return
                }
                if let data = response.responseObject as? NSData {
                    let str = NSString(data: data, encoding: NSUTF8StringEncoding)
                    var er:NSError?
                    var json = JSON(data:data, options: NSJSONReadingOptions.AllowFragments, error: &er)
                    if json == nil{
                        println(er.debugDescription)
                    }
                    let temp = json["zContent"]
                    println(temp)
                    var list = CJSON.paraList(temp,modelName: "SafeItems",context:context)
                    context.save(nil)
                }
        })
        

    }
}
