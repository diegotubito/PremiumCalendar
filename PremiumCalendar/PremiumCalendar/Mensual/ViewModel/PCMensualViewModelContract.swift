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
    func getNameDay(index: Int) -> String
    func getDayValues(fila: Int, columna: Int) -> PCMensualValores
 }

protocol PCMensualViewContract {
    func updateView()
    func deselectAll()
    func getLabelFont(_ valor: PCMensualValores) -> UIFont
    func getLabelColor(_ valor: PCMensualValores) -> UIColor

   

    func showSelectedItems()
}


