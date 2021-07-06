//
//  CourseLevelFactory.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 06/07/2021.
//

import Foundation

class CourseLevelFactory
{
    public static func courseFromDictonnary (_ dict:[String:Any]) -> CourseLevel{
        
        let id = dict["id"] as? String
        let libelle = dict["libelle"] as? String
        
        return CourseLevel(id: id, libelle: libelle)
        
    }
    
    public static func dictonnaryFromCourse (_ course:CourseLevel ) -> [String:Any]{
    
        var dict: [String: Any] = [:]
        dict["id"] = course.id
        dict["libelle"] = course.libelle
        
        if let id = course.id {
            dict["id"] = id
        }
    
        if let libelle = course.libelle {
            dict["libelle"] = libelle
        }

        return dict
    
    }
}
