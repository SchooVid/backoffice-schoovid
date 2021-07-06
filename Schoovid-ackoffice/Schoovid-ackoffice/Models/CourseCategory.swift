//
//  CourseCategory.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 03/07/2021.
//

import Foundation

class CourseCategory : CustomStringConvertible {
    
    var id: String?
    var libelle: String?
    var description: String {
        return "Course category : { \(self.id) , \(self.libelle) }"
    }
    
    public init(id : String?, libelle : String?)
    {
        self.id = id
        self.libelle = libelle
    }
}
