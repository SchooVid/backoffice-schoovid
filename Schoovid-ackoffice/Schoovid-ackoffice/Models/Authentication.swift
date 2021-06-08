//
//  Authentication.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 08/06/2021.
//

import Foundation

class Authentication: CustomStringConvertible {
    var username:String!
    var password: String!
    var description: String {
        return "Auth : [\(self.username),\(self.password)]"
    }
    
    public init (username : String?, password: String?){
        self.username = username;
        self.password = password;
    }
}
