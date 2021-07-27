//
//  Comment.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 25/07/2021.
//

import Foundation


struct Comment {
    var text : String
    var username : String
    
    init(dict : [String : AnyObject])
    {
        text = dict["text"] as! String
        username = dict["user"] as! String
    }
}
