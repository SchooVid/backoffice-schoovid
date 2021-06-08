//
//  AuthenticationFactory.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 08/06/2021.
//

import Foundation


class AuthenticationFactory {
    
    public static func AuthFromDictionnary (_ dict:[String:Any]) -> Authentication{
        
        let username = dict["username"] as? String
        let password = dict["password"] as? String
        
        return Authentication(username: username, password: password)
        
    }
    
    public static func dictionnaryFromAuthentication(_ login:Authentication ) -> [String:Any]{
    
        var dict: [String: Any] = [:]
        dict["username"] = login.username
        dict["password"] = login.password
       
        if let username = login.username {
            dict["username"] = username
        }
        
        if let password = login.password {
            dict["password"] = password
        }
           
        return dict
    
    }
}
