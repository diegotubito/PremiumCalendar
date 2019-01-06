//
//  SETableViewCellDate.swift
//  redLinkTest
//
//  Created by David Diego Gomez on 30/12/18.
//  Copyright © 2018 Gomez David Diego. All rights reserved.
//

import UIKit

protocol SETableViewCellDateDelegate {
    func dateChanged(tableViewCell: UITableViewCell, date: Date)
}

class SETableViewCellDate: UITableViewCell {
    
    var delegate : SETableViewCellDateDelegate?

    @IBOutlet var titleCell: UILabel!
    @IBOutlet var dateCell: UIDatePicker!
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let loc = Locale(identifier: "es")
        self.dateCell.locale = loc
        
    }

    @IBAction func dateHasChanged(_ sender: UIDatePicker) {
        self.delegate?.dateChanged(tableViewCell: self, date: sender.date)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
