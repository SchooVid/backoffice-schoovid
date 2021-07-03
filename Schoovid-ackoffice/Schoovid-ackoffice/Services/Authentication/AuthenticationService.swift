//
//  AuthenticationService.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 08/06/2021.
//

import Foundation

class AuthenticationService {
    public func auth(login : Authentication, completion: @escaping (User?)->Void)->Void {
            
            guard let authURL = URL(string : "http://localhost:3000/auth/signin/") else {
                completion(nil)
                return
            }
            
            var request = URLRequest(url : authURL)
            request.httpMethod = "POST"
            
            let dict = AuthenticationFactory.dictionnaryFromAuthentication(login)
            let data = try? JSONSerialization.data(withJSONObject: dict, options: .fragmentsAllowed)
            request.httpBody = data
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with:request){ (data,response,error) in
                guard error == nil, let d = data else {
                    completion(nil)
                    return
                }
                let userData = try? JSONSerialization.jsonObject(with: d, options: .allowFragments)
                
                guard let user = userData as? [String: Any] else {
                    completion(nil)
                    return
                }
        
                let res = UserFactory.userFromDictonnary(user )
                completion(res)
            }
            task.resume()
            
            
        }
}
