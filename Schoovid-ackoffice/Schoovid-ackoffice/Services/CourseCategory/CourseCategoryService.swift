//
//  CourseCategoryService.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 03/07/2021.
//

import Foundation

class CourseCategoryService {
    
    public func getAllCourseCategory(completion : @escaping ([CourseCategory]) -> Void ) -> Void
    {
        guard let courseCategoryURL = URL(string:"http://51.178.139.94:3000/course_category/")
        else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with : courseCategoryURL) { (data,response,error) in
            guard error == nil, let d = data else
            {
                completion([])
                return
            }
            
            let courseCategoryAny = try? JSONSerialization.jsonObject(with: d, options: .allowFragments)
            
            guard let courseCategory = courseCategoryAny as? [ [String:Any] ] else
            {
                completion([])
                return
            }
            
            let res = courseCategory.compactMap(CourseCategoryFactory.courseFromDictonnary(_:))
            
            completion(res)
        }
        
        task.resume()
    }
    
}
