//
//  PCMensualViewModelContract.swift
//  PremiumCalendar
//
//  Created by David Diego Gomez on 6/1/19.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import UIKit

protocol PCMensualViewModelContract {
    init(withCustomView view: PCMensualViewContract)
    func selectedView(_ tuple : (Int, Int))
    var model : PCMensualModel {get set}
}

protocol PCMensualViewContract {
    func updateView()
    func deselectAll()
 
    func showSelectedItems()
 }
