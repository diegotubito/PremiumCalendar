//
//  SETableViewCellOptionalDate.swift
//  redLinkTest
//
//  Created by David Diego Gomez on 31/12/18.
//  Copyright © 2018 Gomez David Diego. All rights reserved.
//

import UIKit

protocol SETableViewCellOptionalDateDelegate {
    func dateChangedOptional(tableViewCell: UITableViewCell, date: Date)
    func switchChanged(tableViewCell: UITableViewCell, isOn: Bool)
}

class SETableViewCellOptionalDate: UITableViewCell {
    
    var delegate : SETableViewCellOptionalDateDelegate?

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var switchCell: UISwitch!
    @IBOutlet var viewPicker: UIView!
    @IBOutlet var datePickerCell: UIDatePicker!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let loc = Locale(identifier: "es")
        self.datePickerCell.locale = loc
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        viewPicker.isHidden = true
        switchCell.setOn(false, animated: false)
        // Configure the view for the selected state
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        if switchCell.isOn {
            viewPicker.isHidden = false
        } else {
            viewPicker.isHidden = true
            datePickerCell.date = Date()
        }
        self.delegate?.switchChanged(tableViewCell: self, isOn: switchCell.isOn)
    }
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        self.delegate?.dateChangedOptional(tableViewCell: self, date: sender.date)
    }
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
