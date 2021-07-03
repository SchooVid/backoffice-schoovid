//
//  CreateCourseViewController.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 01/07/2021.
//

import UIKit

class CreateCourseViewController: UIViewController{

    @IBOutlet var libelle: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    @IBOutlet var dateDiffusionDatePicker: UIDatePicker!
    @IBOutlet var dateFinDiffusionDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable");
        super.viewDidLoad()
        self.title = "Ajouter un cours"
        
        
    }

    @IBAction func handleAdd(_ sender: Any) {
    
        //Format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = "dd-mm-YYYY H:MM:00g"
        
        let dateDiffusion = dateFormatter.string(from: dateDiffusionDatePicker.date) 
        let dateFinDiffusion = dateFormatter.string(from : dateFinDiffusionDatePicker.date) 
        let courseLibelle = self.libelle.text ?? ""
        
        
        //Control values
        guard dateDiffusion.count > 0, dateFinDiffusion.count > 0
        else {
            
            let alert = UIAlertController(title:"Erreur",message:"Date de début de diffusion et la date de fin de diffusion sont obligatoires",preferredStyle: .alert)
            self.present(alert, animated: true){
                Timer.scheduledTimer(withTimeInterval: 1, repeats:false){ (_) in
                    alert.dismiss(animated:true)
                    
                }
            }
            
            return
        }
        
        guard courseLibelle.count > 0
        else {
            
            let alert = UIAlertController(title:"Erreur",message:"Libelle de cours obligatoire",preferredStyle: .alert)
            self.present(alert, animated: true){
                Timer.scheduledTimer(withTimeInterval: 1, repeats:false){ (_) in
                    alert.dismiss(animated:true)
                }
            }
            
            return
        }
        

    }
}


