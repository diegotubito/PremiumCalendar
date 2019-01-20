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
    func getMonthName() -> String

    
    func avanzarMes()
    func retrocederMes()
 }

protocol PCMensualViewContract {
    func updateView()
    func deselectAll()
    func updateDays()
    func getDayAttibutes(fecha: Date, fila: Int, columna: Int) -> PCMensualDayAttribute
    

    func showSelectedItems()
}


