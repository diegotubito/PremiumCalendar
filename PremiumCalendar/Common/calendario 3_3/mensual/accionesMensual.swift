//
//  accionesMensual.swift
//  calendario3_1
//
//  Created by David Diego Gomez on 17/1/18.
//  Copyright © 2018 David Diego Gomez. All rights reserved.
//

import Foundation
import UIKit

extension CalendarioMensual {
    @objc func tituloTapped(sender : UITapGestureRecognizer) {
        print("seleccionar año")
        self.delegateMensual?.cambiarCalendarioMensual()
    }
    
    @objc func mesTapped(sender : UITapGestureRecognizer) {
        mesSeleccionado = (sender.view?.tag)!
        highlightedMonth = mesSeleccionado
        highlightedYear = añoEnPantalla
        
        reboteBoton(layer: datos.meses[(sender.view?.tag)! - 1].fondoMes.layer)
       timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
    }
    
    @objc func runTimedCode() {
        
        timer.invalidate()
        layer.removeAllAnimations()
        self.delegateMensual?.mesAñoSeleccionado(mes: mesSeleccionado, año: añoEnPantalla)
    
    }
    
    @objc func swipeLeft(sender: UISwipeGestureRecognizer) {
        añoEnPantalla = añoEnPantalla + 1
        animarSwipeIzquierdo(label: datos.labelTitulo)
        for i in datos.meses {
            temblar(layer: i.labelMes.layer)
        }
        
    }
    @objc func swipeRight(sender: UISwipeGestureRecognizer) {
        añoEnPantalla = añoEnPantalla - 1
        animarSwipeDerecho(label: datos.labelTitulo)
        for i in datos.meses {
            temblar(layer: i.labelMes.layer)
        }
    }
}
