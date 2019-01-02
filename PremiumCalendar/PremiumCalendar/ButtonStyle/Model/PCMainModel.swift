//
//  PCMainModel.swift
//  PremiumCalendar
//
//  Created by David Diego Gomez on 2/1/19.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import Foundation

class PCButtonStyleModel {
    var selectedDay : String
    var selectedMonth : String
    
    init() {
        self.selectedDay = Date().toString(formato: "dd")
        self.selectedMonth = Date().toString(formato: "MM")
    }
}
