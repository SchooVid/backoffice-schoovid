//
//  ProposedCourseFactory.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 21/07/2021.
//

import Foundation

class ProposedCourseFactory{
    
    public static func proposedCourseFromDictonnary (_ dict:[String:Any]) -> ProposedCourse{
        
        let id = dict["id"] as? String
        let libelle = dict["libelle"] as? String
        let desc = dict["description"] as? String
        let userId = dict["userId"] as? String
        let categorie_libelle = dict["categorie_libelle"] as? String
        let niveau_libelle = dict["niveau_libelle"] as? String
        let prenom = dict["firstname"] as? String
        let nom = dict["lastname"] as? String
        
        return ProposedCourse(id: id, libelle: libelle, desc: desc, userId: userId,categorie_libelle: categorie_libelle,niveau_libelle: niveau_libelle, prenom: prenom,nom: nom)
        
    }
    
    public static func dictonnaryFromProposedCourse (_ course: ProposedCourse ) -> [String:Any]{
    
        var dict: [String: Any] = [:]
        dict["id"] = course.id
        dict["libelle"] = course.libelle
        dict["description"] = course.desc
        dict["userId"] = course.userId
        dict["categorie_libelle"] = course.categorie_libelle
        dict["niveau_libelle"] = course.niveau_libelle
        dict["firstname"] = course.prenom
        dict["lastname"] = course.nom
       
        if let id = course.id {
            dict["id"] = id
        }
    
        if let libelle = course.libelle {
            dict["libelle"] = libelle
        }
        
        if let desc = course.desc {
            dict["description"] = desc
        }
        
        if let userId = course.userId {
            dict["userId"] = userId
        }
        
        if let niveau_libelle = course.niveau_libelle {
            dict["niveau_libelle"] = niveau_libelle
        }
        
        if let categorie_libelle = course.categorie_libelle {
            dict["categorie_libelle"] = categorie_libelle
        }
        
        if let nom = course.nom {
            dict["lastname"] = nom
        }
        
        if let prenom = course.prenom {
            dict["firstname"] = prenom
        }
        
        return dict
    
    }
    
}
