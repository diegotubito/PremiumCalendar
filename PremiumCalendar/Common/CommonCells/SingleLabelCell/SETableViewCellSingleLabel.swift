//
//  SETableViewCellSingleLabel.swift
//  redLinkTest
//
//  Created by David Diego Gomez on 31/12/18.
//  Copyright © 2018 Gomez David Diego. All rights reserved.
//

import UIKit

class SETableViewCellSingleLabel: UITableViewCell {
    
    
    @IBOutlet var leftLabel: UILabel!
    @IBOutlet var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
