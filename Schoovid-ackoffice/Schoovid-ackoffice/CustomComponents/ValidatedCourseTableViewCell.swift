//
//  ValidatedCourseTableViewCell.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 29/06/2021.
//

import UIKit

class ValidatedCourseTableViewCell: UITableViewCell {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var startintDateLabel: UILabel!
    @IBOutlet var endingDateLabel: UILabel!
    
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
