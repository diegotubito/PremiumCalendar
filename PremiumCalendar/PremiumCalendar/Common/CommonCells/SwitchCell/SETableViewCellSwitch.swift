//
//  SETableViewCellLabelSwitch.swift
//  redLinkTest
//
//  Created by David Diego Gomez on 30/12/18.
//  Copyright © 2018 Gomez David Diego. All rights reserved.
//

import UIKit

protocol SETableViewCellSwitchDelegate {
    func switchHasChanged(tableViewCell: UITableViewCell, isOn: Bool)
}

class SETableViewCellSwitch: UITableViewCell {
    var delegate : SETableViewCellSwitchDelegate?

    @IBOutlet var titleCell: UILabel!
    @IBOutlet var mySwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchHasChanged(_ sender: UISwitch) {
        self.delegate?.switchHasChanged(tableViewCell: self, isOn: sender.isOn)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
