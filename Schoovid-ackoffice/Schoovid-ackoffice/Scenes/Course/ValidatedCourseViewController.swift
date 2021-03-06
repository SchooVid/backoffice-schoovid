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
        
        super.viewDidLoad()
        self.view.translatesAutoresizingMaskIntoConstraints = true;
        title = "Liste des cours validés"
 
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
        let createCourse = CreateCourseViewController.newInstance(user: user, action: "Ajouter")
        navigationController?.pushViewController(createCourse, animated: true)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.courses.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let course = self.courses[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "course-cell", for: indexPath) as! ValidatedCourseTableViewCell
    
        let startingDate = ISO8601ToLocalDate(isoDate : course.date_diffusion!).components(separatedBy: " ")
        
        let endingDate = ISO8601ToLocalDate(isoDate : course.date_fin_diffusion!).components(separatedBy: " ")
        
        if(course.desc?.count == 0)
        {
            course.desc = NSLocalizedString("cell.noDescription", comment: "")
        }
        
        cell.titleLabel.text = course.libelle
        cell.descriptionLabel.text = NSLocalizedString("cell.description", comment: "") + " : \(course.desc ?? NSLocalizedString("cell.noDescription", comment: ""))"
        
        cell.endingDateLabel.text = NSLocalizedString("cell.endingDate", comment: "") + " : \(endingDate[0]) - \(endingDate[1])"
        
        cell.startintDateLabel.text = NSLocalizedString("cell.startingDate", comment: "") + " : \(startingDate[0]) - \(startingDate[1]) "
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let course = self.courses[indexPath.section]
        
        let liveAnDetail = LiveAndDetailViewController.newInstance(user: user, course: course)
        
        self.navigationController?.pushViewController(liveAnDetail, animated: true)
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
