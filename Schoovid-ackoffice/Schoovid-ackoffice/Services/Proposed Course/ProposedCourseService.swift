//
//  ProposedCourseService.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 21/07/2021.
//

import Foundation

class ProposedCourseService {
    
    public func list(completion : @escaping ([ProposedCourse]) -> Void) -> Void {
        
        guard let apiCourseURL = URL(string:"http://51.178.139.94:3000/proposed_course/all")
        else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: apiCourseURL) {
            (data, response, error) in
            
            guard error == nil, let d = data else {
                completion([])
                return
            }
            
            let courseAny = try? JSONSerialization.jsonObject(with: d, options: .allowFragments)
            guard let course = courseAny as? [ [String:Any] ] else {
                completion([])
                return
            }
            
            let res = course.compactMap(ProposedCourseFactory.proposedCourseFromDictonnary(_:))
            
            completion(res)
        }
        task.resume()
    }
    
}
