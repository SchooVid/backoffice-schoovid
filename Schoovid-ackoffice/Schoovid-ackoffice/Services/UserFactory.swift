//
//  UserFactory.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 08/06/2021.
//

import Foundation

class UserFactory{
    
    public static func userFromDictonnary (_ dict:[String:Any]) -> User{
        
        let id = dict["id"] as? String
        let username = dict["username"] as? String
        let role = dict["role"] as? String
        
        return User(id:id,username : username, role : role)
        
    }
    
    public static func dictonnaryFromUser (_ user:User ) -> [String:Any]{
    
        var dict: [String: Any] = [:]
            dict["id"] = user.id
            dict["username"] = user.username
            dict["role"] = user.role
        
        
        
        if let id = user.id {
            dict["id"] = id
        }
    
          
        if let username = user.username {
            dict["username"] = username
        }
        
        if let role = user.role {
            dict["role"] = role
        }
        return dict
    
    }
    
}
