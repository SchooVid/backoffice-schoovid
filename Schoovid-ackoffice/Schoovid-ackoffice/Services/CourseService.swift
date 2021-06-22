//
//  CourseService.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 22/06/2021.
//

import Foundation

class CourseService {
    
    public func list(completion : @escaping ([Course]) -> Void) -> Void {
        
        guard let apiCourseURL = URL(string:"http://localhost:3000/course/all")
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
            
            let res = course.compactMap(CourseFactory.courseFromDictonnary(_:))
            
            completion(res)
        }
        task.resume()
    }
    
}
