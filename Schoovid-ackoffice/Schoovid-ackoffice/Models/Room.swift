//
//  Room.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 19/07/2021.
//

import Foundation

struct Room {
    
    var key : String
    var title : String
    
    init(dict : [String:AnyObject]) {
        
        title = dict["title"] as! String
        key = dict["key"] as! String
        
    }
    
    func toDict() -> [String:AnyObject]
    {
        return [
            "title" : title as AnyObject,
            "key"   : key as AnyObject
        ]
    }
    
}
