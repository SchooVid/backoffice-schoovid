//
//  CourseLevelService.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 06/07/2021.
//

import Foundation

class CourseLevelService
{
    public func getAllCourseLevel(completion : @escaping ([CourseLevel]) -> Void ) -> Void
    {
        guard let courseLevelURL = URL(string:"http://51.178.139.94:3000/course_level/")
        else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with : courseLevelURL) { (data,response,error) in
            guard error == nil, let d = data else
            {
                completion([])
                return
            }
            
            let courseCategoryAny = try? JSONSerialization.jsonObject(with: d, options: .allowFragments)
            
            guard let courseLevel = courseCategoryAny as? [ [String:Any] ] else
            {
                completion([])
                return
            }
            
            let res = courseLevel.compactMap(CourseLevelFactory.courseFromDictonnary(_:))
            
            completion(res)
        }
        
        task.resume()
    }
}
