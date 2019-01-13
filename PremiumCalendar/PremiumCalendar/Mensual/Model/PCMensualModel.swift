//
//  PCModel.swift
//  PremiumCalendar
//
//  Created by David Diego Gomez on 6/1/19.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import UIKit

/*
struct PCMensualSelectionMode {
    let mode : Int
    static var singleSelection : PCMensualSelectionMode {return PCMensualSelectionMode(mode: 0)}
    static var doubleSelection : PCMensualSelectionMode {return PCMensualSelectionMode(mode: 1)}
    static var randomSelection : PCMensualSelectionMode {return PCMensualSelectionMode(mode: 2)}
}
*/

struct PCMensualSelectionMode {
    static let singleSelection = 0
    static let doubleSelection = 1
    static let randomSelection = 2
    static let dragSelection = 3
}

class PCMensualModel {
    var selectionMode : Int!
    var selectedItems : [Int]!
    
    
    init(selectionMode: Int, selectedItems: [Int]) {
        self.selectionMode = selectionMode
        self.selectedItems = selectedItems
 
    }
}
