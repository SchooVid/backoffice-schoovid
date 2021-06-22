//
//  Course.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 22/06/2021.
//

import Foundation

class Course: CustomStringConvertible{
    
    var id:String?
    var libelle: String?
    var desc:String?
    var date_diffusion:String?
    var date_fin_diffusion:String?
    var lien_diffusion:String?
    var formateurId:String?
    var niveauId:String?
    var categorieId:String?
    
    var description: String{
        return "User : { \(self.id), \(self.libelle), \(self.desc), \(self.date_diffusion), \(self.date_fin_diffusion), \(self.lien_diffusion), \(self.formateurId), \(self.niveauId), \(self.categorieId)   }"
    }
    
    public init(id : String?, libelle : String?, desc : String?, date_diffusion : String?, date_fin_diffusion : String?, lien_diffusion : String?, formateurId : String?, niveauId : String?, categorieId : String?){
        self.id                 = id
        self.libelle            = libelle
        self.desc               = desc
        self.date_diffusion     = date_diffusion
        self.date_fin_diffusion = date_fin_diffusion
        self.lien_diffusion     = lien_diffusion
        self.formateurId        = formateurId
        self.niveauId           = niveauId
        self.categorieId        = categorieId
    }
    
}
