//
//  CourseFactory.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 22/06/2021.
//

import Foundation

class CourseFactory{
    
    public static func courseFromDictonnary (_ dict:[String:Any]) -> Course{
        
        let id = dict["id"] as? String
        let libelle = dict["libelle"] as? String
        let desc = dict["desc"] as? String
        let date_diffusion = dict["date_diffusion"] as? String
        let date_fin_diffusion = dict["date_fin_diffusion"] as? String
        let lien_diffusion = dict["lien_diffusion"] as? String
        let formateurId = dict["formateurId"] as? String
        let niveauId = dict["niveauId"] as? String
        let categorieId = dict["categorieId"] as? String
        
        return Course(id: id, libelle: libelle, desc: desc, date_diffusion: date_diffusion, date_fin_diffusion: date_fin_diffusion, lien_diffusion: lien_diffusion, formateurId: formateurId, niveauId: niveauId, categorieId: categorieId)
        
    }
    
    public static func dictonnaryFromCourse (_ course:Course ) -> [String:Any]{
    
        var dict: [String: Any] = [:]
        dict["id"] = course.id
        dict["libelle"] = course.libelle
        dict["desc"] = course.desc
        dict["date_diffusion"] = course.date_diffusion
        dict["date_fin_diffusion"] = course.date_fin_diffusion
        dict["lien_diffusion"] = course.lien_diffusion
        dict["formateurId"] = course.formateurId
        dict["niveauId"] = course.niveauId
        dict["categorieId"] = course.categorieId
        
        
        
        
        if let id = course.id {
            dict["id"] = id
        }
    
        if let libelle = course.libelle {
            dict["libelle"] = libelle
        }
        
        if let desc = course.desc {
            dict["desc"] = desc
        }
        
        if let date_diffusion = course.date_diffusion {
            dict["date_diffusion"] = date_diffusion
        }
        
        if let date_fin_diffusion = course.date_fin_diffusion {
            dict["date_fin_diffusion"] = date_fin_diffusion
        }
        
        if let lien_diffusion = course.lien_diffusion {
            dict["lien_diffusion"] = lien_diffusion
        }
        
        if let formateurId = course.formateurId {
            dict["formateurId"] = formateurId
        }
        
        if let niveauId = course.niveauId {
            dict["niveauId"] = niveauId
        }
        
        if let categorieId = course.categorieId {
            dict["categorieId"] = categorieId
        }
        
        return dict
    
    }
    
}
