//
//  User.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 08/06/2021.
//

import Foundation

class User: CustomStringConvertible{
    
    var id:String?
    var username: String?
    var role:String?
    
    var description: String{
        return "User : { \(self.id), \(self.username), \(self.role) }"
    }
    
    public init(id : String?, username : String?, role : String?){
        self.id = id;
        self.username = username;
        self.role = role;
    }
    
}
