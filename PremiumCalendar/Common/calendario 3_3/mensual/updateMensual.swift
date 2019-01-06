//
//  updateMensual.swift
//  calendario3_1
//
//  Created by David Diego Gomez on 18/1/18.
//  Copyright © 2018 David Diego Gomez. All rights reserved.
//

import Foundation
import UIKit

extension CalendarioMensual {
    func updateValues() {
        for (index, mes) in datos.meses.enumerated() {
            let mesNombre = MESES[index + 1]
            if let formaCorta = mesNombre?.prefix(3) {
                mes.labelMes.text = String(formaCorta)
             //   let d = drand48()
             //   mes.labelMes.alpha = CGFloat(d)
             //   mes.fondoMes.backgroundColor = UIColor.gray.withAlphaComponent(CGFloat(d))
                
            }
            if highlightedMonth == (index + 1) && añoEnPantalla == highlightedYear{
                mes.fondoMes.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
                mes.labelMes.textColor = UIColor.white
            } else {
                mes.fondoMes.backgroundColor = UIColor.clear
                mes.labelMes.textColor = atributosPantalla.modoMensual.fonts.nombreMesesColor
            }
        }
    }
}
