//
//  ChatTableViewCell.swift
//  Schoovid-ackoffice
//
//  Created by Nicolas TRAN on 25/07/2021.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet var nameAndCommentLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundColor = UIColor.clear
       
        
    }
    
}
