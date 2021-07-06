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
    @IBOutlet var categoryPickerView: UIPickerView!
    
    var courseCategories : [CourseCategory] = []
    var courseCategoriesService : CourseCategoryService = CourseCategoryService()
    
    var pickerData : [String] = [String]()
    var idSelected : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ajouter un cours"
        
        self.categoryPickerView.delegate = self
        self.categoryPickerView.dataSource = self
        
        pickerData = ["Item 1","Item 2"]
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.courseCategoriesService.getAllCourseCategory {
            (category) in
            self.courseCategories = category
            DispatchQueue.main.sync {
                self.categoryPickerView.reloadAllComponents()
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

extension CreateCourseViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return courseCategories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        let category = courseCategories[row]
        return category.libelle
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.idSelected = courseCategories[row].id!
        print(self.idSelected)
    }
    
}


extension CreateCourseViewController : UIPickerViewDelegate {
    
}

