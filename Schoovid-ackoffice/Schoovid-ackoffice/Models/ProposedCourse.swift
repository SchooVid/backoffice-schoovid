//
//  ProposedCourse.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 21/07/2021.
//

import Foundation

class ProposedCourse : CustomStringConvertible {
    
    var id: String?
    var libelle: String?
    var desc : String?
    var userId : String?
    var categorie_libelle : String?
    var niveau_libelle : String?
    var prenom : String?
    var nom : String?
    var description: String {
        return "Course level : { \(self.id) , \(self.libelle) }"
    }
    
    public init(id : String?, libelle : String?, desc : String?, userId : String?,categorie_libelle : String?, niveau_libelle : String?, prenom : String?, nom : String?)
    {
        self.id = id
        self.libelle = libelle
        self.desc = desc
        self.userId = userId
        self.categorie_libelle = categorie_libelle
        self.niveau_libelle = niveau_libelle
        self.prenom = prenom
        self.nom = nom
    }
}
