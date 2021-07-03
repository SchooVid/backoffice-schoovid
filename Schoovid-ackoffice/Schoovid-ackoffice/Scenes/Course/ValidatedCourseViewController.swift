//
//  ValidatedCourseViewController.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 22/06/2021.
//

import UIKit

class ValidatedCourseViewController: UIViewController {

    @IBOutlet var tableViewCourse: UITableView!
    var user : User!
    var courses: [Course] = []
    let courseService: CourseService = CourseService()
    
    
    static func newInstance(user: User) -> ValidatedCourseViewController
    {
        let validatedCourseController = ValidatedCourseViewController()
        validatedCourseController.user = user
        
        return validatedCourseController
    }
    
    override func viewDidLoad() {
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable");
        
        super.viewDidLoad()
        title = "Liste des cours validés"
        view.backgroundColor = .systemBlue
 
        self.tableViewCourse.dataSource = self
        self.tableViewCourse.delegate = self
        
        self.tableViewCourse.register(UINib(nibName: "ValidatedCourseTableViewCell", bundle: nil), forCellReuseIdentifier: "course-cell")
        self.tableViewCourse.rowHeight = UITableView.automaticDimension
        
        self.navigationItem.rightBarButtonItems = [
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAddProduct))
        ]
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func handleAddProduct() {
        navigationController?.pushViewController(CreateCourseViewController(), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.courseService.getCourseFromUser(userId: self.user.id!, completion: { (course) in
            self.courses = course
            DispatchQueue.main.sync {
                self.tableViewCourse.reloadData()
            }
            
        })
    }
}

extension ValidatedCourseViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let course = self.courses[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "course-cell", for: indexPath) as! ValidatedCourseTableViewCell
    
        let startingDate = ISO8601ToLocalDate(isoDate : course.date_diffusion!).components(separatedBy: " ")
        
        let endingDate = ISO8601ToLocalDate(isoDate : course.date_fin_diffusion!).components(separatedBy: " ")
        
        cell.titleLabel.text = course.libelle
        cell.descriptionLabel.text = course.desc
        cell.endingDateLabel.text = "Le \(endingDate[0]) à \(endingDate[1]) "
        cell.startintDateLabel.text = "Le \(startingDate[0]) à \(startingDate[1]) "
        
        return cell
    }
    
    
}

extension ValidatedCourseViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let course = self.courses[indexPath.row]
        
        guard let id = course.id
        else {
            return
        }
        self.courseService.deleteCourse(courseId: id, completion: {
            (success) in
            
            DispatchQueue.main.sync {
                self.courses.remove(at : indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let course = self.courses[sourceIndexPath.row]
        self.courses.remove(at: sourceIndexPath.row)
        self.courses.insert(course, at: destinationIndexPath.row)
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
