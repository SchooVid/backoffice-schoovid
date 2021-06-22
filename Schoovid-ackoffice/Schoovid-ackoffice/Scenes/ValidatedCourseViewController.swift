//
//  ValidatedCourseViewController.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 22/06/2021.
//

import UIKit

class ValidatedCourseViewController: UIViewController {

    @IBOutlet var tableViewCourse: UITableView!
    var courses: [Course] = []
    let courseService: CourseService = CourseService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Liste des cours validés"
        view.backgroundColor = .systemBlue
        
        self.tableViewCourse.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.courseService.list(completion: { (courses) in
                
            self.courses = courses
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
        let cell = self.getCourseCell(tableView: tableView)
        cell.textLabel?.text = course.libelle
        
        return cell
    }
    
    func getCourseCell(tableView : UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "course_identifier")
        else {
            return UITableViewCell(style: .default, reuseIdentifier: "course_identifier")
        }
        
        return cell
    }
}

extension ValidatedCourseViewController : UITableViewDelegate {
  
}
