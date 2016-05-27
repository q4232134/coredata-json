//
//  CJSON.swift
//
//  Created by apple on 15/8/31.
//  Copyright (c) 2015年 apple. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON

/// 针对coreData所设计的json工具类，可以将JSON和coreData的model（NSManagedObject）进行互相转化
/// 需要SwifyJson支持
/// 不支持model内的Array或者Dictionary
class CJSON{
    
    /**
    将model转换成JSON
    
    :param: object
    
    :returns: json
    */
    static func jsonToString(object:NSManagedObject,modelName:String) -> JSON{
        return jsonToString([object])[0]
    }
    
    /**
    将model数组转换成JSON
    
    :param: list
    
    :returns: json数组
    */
    static func jsonToString(list:[NSManagedObject]) -> JSON{
        let t: AnyObject = list as AnyObject
        if list.isEmpty{
            return "[]"
        }
        let proList = getProtocolList(list[0].entity)
        var dicList = [JSON]()
        for entry in list{
            var dic = [String : JSON]()
            for temp in proList {
                if var value: AnyObject = entry.valueForKey(temp.0){
                    if(value is NSDate){
                        value = (value as! NSDate).timeIntervalSince1970 * 1000
                    }
                    dic.updateValue(JSON(value), forKey: temp.0)
                }
            }
            dicList.append(JSON(dic))
        }
        return JSON(dicList)
    }
    
    
    /**
    根据NSEntityDescription来获取类型字典
    
    :param: entity NSEntityDescription
    
    :returns: 类型字典 <字段名称：字段类型>
    */
    static func getProtocolList(entity:NSEntityDescription) -> [String:String]{
        ///类型字典
        var list = [String:String]()
        let des = entity.managedObjectModel.entitiesByName[entity.name!]! as! NSEntityDescription
        for t in entity.managedObjectModel.entitiesByName {
            for s in des.properties{
                list.updateValue(s.attributeValueClassName!!, forKey: s.name)
            }
        }
        return list
    }
    
    
    /**
    将指定数据转换成可以存入entry的类型
    
    :param: type  数据类型
    :param: value 数据值(JSON)类型
    
    :returns: 转换后的值
    */
    static private func getObjectByType(type:String,value:JSON) -> AnyObject{
        var ob:AnyObject
        switch(type){
        case "NSDate" :ob = NSDate(timeIntervalSince1970: value.doubleValue / 1000)
        case "NSString" :ob = value.stringValue
        case "NSNumber" :ob = value.numberValue
        default :ob = value.object
        }
        return ob
    }
    
    /**
    把JSON的list解包成指定对象的list
    :param: dataList  JSONlist
    :param: isList    是否为列表
    :param: modelStr  model类型的字符串
    :param: context   NSManagedObjectContext
    
    :returns:  转换后的对象列表
    */
    static func paraList(json:JSON , modelName:String, context:NSManagedObjectContext) ->[NSManagedObject]{
        /// 从字符串确定model类型，并进行数据类型解析
        let entity = NSEntityDescription.entityForName(modelName, inManagedObjectContext: context)
        let entry = NSManagedObject(entity :entity!,  insertIntoManagedObjectContext: context)
        let list = getProtocolList(entity!)
        var resultList = [NSManagedObject]()
        for (key: String, subJson: JSON) in json {
            let entry = NSManagedObject(entity :entity!,  insertIntoManagedObjectContext: context)
            for temp in list {
                entry.setValue(getObjectByType(temp.1, value: subJson[temp.0]), forKey: temp.0)
            }
            resultList.append(entry)
        }
        return resultList
    }
}