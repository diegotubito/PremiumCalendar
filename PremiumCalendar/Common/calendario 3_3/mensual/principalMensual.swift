//
//  principal.swift
//  calendario3_1
//
//  Created by David Diego Gomez on 16/1/18.
//  Copyright © 2018 David Diego Gomez. All rights reserved.
//

import Foundation
import UIKit

protocol calendarioMensualDelegate: class {
    func cambiarCalendarioMensual()
    func mesAñoSeleccionado(mes: Int, año: Int)
}

class CalendarioMensual: Calendario {
   
    
   
    
    weak var delegateMensual : calendarioMensualDelegate?
    var datos = _datos()
    var timer = Timer()
    
    var highlightedYear = 2017 {
        didSet {
            updateValues()
        }
    }
    var highlightedMonth = 12 {
        didSet {
            updateValues()
        }
    }
    
    
    
    var añoEnPantalla : Int = 2017 {
        didSet {
            print("old value \(oldValue), new value \(añoEnPantalla)")
            mostrarAñoActual()
          updateValues()
        }
    }
    var mesSeleccionado = 12 {
        didSet {
            updateValues()
        }
    }
    
  
    func mostrarAñoActual() {
        datos.labelTitulo.text = String(añoEnPantalla)
    }
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        
        atributoDePantalla.altoTitulo = frame.height / 7
        
        dibujarCalendarioMensual()
       
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


