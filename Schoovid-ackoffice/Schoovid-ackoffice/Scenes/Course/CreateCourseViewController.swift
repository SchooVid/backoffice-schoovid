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
    @IBOutlet var levelPickerView: UIPickerView!
    
    var user: User!
    var course: Course!
    var action : String!
    
    var courseCategories : [CourseCategory] = []
    var courseCategoriesService : CourseCategoryService = CourseCategoryService()
    
    var courseLevels : [CourseLevel] = []
    var courseLevelsService : CourseLevelService = CourseLevelService()
    
    var courseService : CourseService = CourseService()
    
    var idSelectedLevel : String?
    var idSelectedCategory : String?
    
    static func newInstance(user : User, action : String) -> CreateCourseViewController {
        let controller = CreateCourseViewController()
        controller.user = user
        controller.action = action
        return controller
    }
    
    static func newInstance(user : User, course : Course, action : String) -> CreateCourseViewController {
        let controller = CreateCourseViewController()
        controller.user = user
        controller.course = course
        controller.action = action
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Ajouter un cours"
        
        self.levelPickerView.tag = 2
        self.levelPickerView.delegate = self
        self.levelPickerView.dataSource = self
        
        self.categoryPickerView.tag = 1
        self.categoryPickerView.delegate = self
        self.categoryPickerView.dataSource = self
        
        //On modify course
        if(course != nil)
        {
            self.libelle.text = course.libelle
            self.descriptionTextField.text = course.desc
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            
            let date = ISO8601ToLocalDate(isoDate: course.date_diffusion!)
          
            dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
            
            let dateFormatted = dateFormatter.date(from: date)!
            
            let datedate = Date() + 14 * 86400
            
            print(datedate)
            print(dateFormatted)
            
            self.dateDiffusionDatePicker.setDate(datedate, animated: false)
            self.dateFinDiffusionDatePicker.setDate(dateFormatted, animated: false)
        }
        else {
            print("Course is nil so we add a course")
        }
        
    }
    
    
    func ISO8601ToLocalDate(isoDate : String) -> String
    {
        let inputDate = isoDate.replacingOccurrences(of: "T", with: " ")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.sssZ"
        
        let date = dateFormatter.date(from: inputDate) ?? Date()
        dateFormatter.dateFormat = "dd-MM-YYYY HH:mm:ss"
        
        let dateToString = dateFormatter.string(from: date)
        
        return dateToString
    }

    
    override func viewWillAppear(_ animated: Bool) {
        self.courseCategoriesService.getAllCourseCategory {
            (category) in
            
            self.courseCategories = category
            
            DispatchQueue.main.sync {
                self.categoryPickerView.reloadAllComponents()
            }
         
        }
        
        self.courseLevelsService.getAllCourseLevel {
            (level) in
            
          
            self.courseLevels = level
            
            DispatchQueue.main.sync {
                self.levelPickerView.reloadAllComponents()
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
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:00"
        
        let dateDiffusion = dateFormatter.string(from: dateDiffusionDatePicker.date) 
        let dateFinDiffusion = dateFormatter.string(from : dateFinDiffusionDatePicker.date) 
        let courseLibelle = self.libelle.text ?? ""
        let description = self.descriptionTextField.text ?? ""
        let idCategory = self.idSelectedCategory ?? courseCategories[0].id!
        let idLevel = self.idSelectedLevel ?? courseLevels[0].id!
        let userId = self.user.id!
        
        
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
        
        let course = Course(id: nil, libelle: courseLibelle, desc: description, date_diffusion: dateDiffusion, date_fin_diffusion: dateFinDiffusion, lien_diffusion: nil, formateurId: userId, niveauId: idLevel, categorieId: idCategory)
        
        self.courseService.createCourse(course: course) {
            (success) in
            
            if(success)
            {
                self.navigationController?.pushViewController(HomeViewController(), animated: true)
            }
            else {
                //return a popup
            }
        }

    }
}

extension CreateCourseViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var count : Int = 0
        
        if(pickerView.tag == 1)
        {
            count = courseCategories.count
        }
        else if pickerView.tag == 2
        {
            count = courseLevels.count
        }
        
        return count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        var returnedData : String? = ""
        
        if(pickerView.tag == 1)
        {
            let category = courseCategories[row]
            returnedData = category.libelle
        }
        else if(pickerView.tag == 2)
        {
            let level = courseLevels[row]
            returnedData = level.libelle
        }
        
        return returnedData
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if(pickerView.tag == 1)
        {
            self.idSelectedCategory = courseCategories[row].id!
        }
        else if(pickerView.tag == 2)
        {
            self.idSelectedLevel = courseLevels[row].id!
        }
    }
    
}


extension CreateCourseViewController : UIPickerViewDelegate {
    
}

