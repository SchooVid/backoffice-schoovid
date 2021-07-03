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
    
    public func getCourseFromUser(userId : String, completion : @escaping ([Course]) -> Void) -> Void {
        
        guard let apiCourseURL = URL(string:"http://localhost:3000/course/professor-course/\(userId)")
        else
        {
            completion([])
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: apiCourseURL)
        {
                (data,response,error) in
            
            guard error == nil, let d = data else {
                completion([])
                return
            }
            
            let professorCourse = try? JSONSerialization.jsonObject(with: d, options: .allowFragments)
            
            guard let courses = professorCourse as? [ [String:Any] ] else {
                completion([])
                return
            }
            
            let res = courses.compactMap(CourseFactory.courseFromDictonnary(_:))
            completion(res)
        }
        
        task.resume()
        
    }
    
    public func createCourse(course : Course, completion: @escaping (Bool) -> Void) -> Void {
        
        guard let createCourseURL =  URL(string : "http://localhost:3000/course/") else {
            completion(false)
            return
        }
        
        var request = URLRequest(url : createCourseURL)
        request.httpMethod = "POST"
        
        let dict = CourseFactory.dictonnaryFromCourse(course)
        let data = try? JSONSerialization.data(withJSONObject: dict, options: .fragmentsAllowed)
        request.httpBody = data
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) {
            (data,response,error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(false)
                return
            }
            
            completion(httpResponse.statusCode == 201)
        }
        
        task.resume()
        
    }
    
    public func deleteCourse(courseId : String, completion : @escaping(Bool) -> Void) -> Void {
        guard let deleteCourseURL = URL(string:"http://localhost:3000/course/delete/\(courseId)") else {
            completion(false)
            return
        }
        
        print(deleteCourseURL)
        
        var request = URLRequest(url : deleteCourseURL)
        request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) {
            (data,response,error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(false)
                return
            }
            
            completion(httpResponse.statusCode == 204)
        }
        
        task.resume()
    }
    
}
