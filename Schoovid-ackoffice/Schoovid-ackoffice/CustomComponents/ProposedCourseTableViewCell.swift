//
//  ProposedCourseTableViewCell.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 21/07/2021.
//

import UIKit

class ProposedCourseTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var niveauLabel: UILabel!
    @IBOutlet var categorieLabel: UILabel!
    @IBOutlet var proposedBy: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 30.0)
        
        self.backgroundColor = UIColor.white
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 8
        self.clipsToBounds = true

        //Style of the description label
       
    }
}
