//
//  ViewController.swift
//  NetDemo
//
//  Created by apple on 15/8/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import UIKit
import SwiftHTTP
import CoreData
import SwiftyJSON

class ViewController: UIViewController {
    var context : NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

//                let f = NSFetchRequest(entityName: "OperationTicketStep")
//                let list = self.context.executeFetchRequest(f, error: nil) as! [User]
//                println(list.count)
        
        
        
        var ta = HTTPTask()
        ta.POST("http://192.168.1.249:8088/ptlsystem/pdc/Data/updateTable.do",parameters: [
            "_loginid":"admin",
            "_password":"123",
            "tableName":SafeItems.talbeName,
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
                    var list = CJSON.paraList(temp,modelName: "SafeItems",context:self.context)
                    self.context.save(nil)
                }
        })
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

