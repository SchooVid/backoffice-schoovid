//
//  ProposedCourseViewController.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 22/06/2021.
//

import UIKit

class ProposedCourseViewController: UIViewController {

    @IBOutlet var tableViewProposedCourse: UITableView!
    var proposedCourseService : ProposedCourseService = ProposedCourseService()
    var proposedCourses : [ProposedCourse] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("proposed_course.controller.title", comment: "")
        self.tableViewProposedCourse.register(UINib(nibName: "ProposedCourseTableViewCell", bundle: nil), forCellReuseIdentifier: "proposedCourse-cell")
        self.tableViewProposedCourse.dataSource = self
        self.tableViewProposedCourse.delegate   = self
        // Do any additional setup after loading the view.
    }


    override func viewWillAppear(_ animated: Bool) {
        self.proposedCourseService.list(){ (proposedCourse) in
            self.proposedCourses = proposedCourse
            
            DispatchQueue.main.sync {
                self.tableViewProposedCourse.reloadData()
            }
        }
    }

}


extension ProposedCourseViewController : UITableViewDataSource
{
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.proposedCourses.count
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
        let proposedCourse = self.proposedCourses[indexPath.section]
        let cell = tableView.dequeueReusableCell(withIdentifier: "proposedCourse-cell", for: indexPath) as! ProposedCourseTableViewCell
        
        cell.titleLabel.text = proposedCourse.libelle
        cell.proposedBy.text = "\(NSLocalizedString("cell.proposedBy", comment: "")) : \(formatName(lastname: proposedCourse.nom!, firstname: proposedCourse.prenom!))"
        cell.niveauLabel.text = NSLocalizedString("cell.level", comment: "") + " : \(proposedCourse.niveau_libelle!)"
        cell.categorieLabel.text = NSLocalizedString("cell.category", comment: "") + " : \(proposedCourse.categorie_libelle!)"
        cell.descriptionLabel.text = NSLocalizedString("cell.description", comment: "") + " : \(proposedCourse.desc ?? NSLocalizedString("cell.noDescription", comment: ""))"
        
        return cell
    
    }
    
    
}

extension ProposedCourseViewController : UITableViewDelegate
{
    
}

func formatName(lastname : String, firstname : String) -> String
{
    let formatted_firstname = firstname.prefix(1).uppercased() + firstname.dropFirst()
    let formatted_lastname = lastname.uppercased();
    
    let returned_string = "\(formatted_lastname) \(formatted_firstname)"
    
    return returned_string;
    
}
