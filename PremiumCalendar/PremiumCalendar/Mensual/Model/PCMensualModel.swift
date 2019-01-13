//
//  PCModel.swift
//  PremiumCalendar
//
//  Created by David Diego Gomez on 6/1/19.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import UIKit


struct PCMensualDias {
    let raw : Int
    static var domingo : PCMensualDias {return PCMensualDias(raw: 0)}
    static var lunes : PCMensualDias {return PCMensualDias(raw: 1)}
    static var martes : PCMensualDias {return PCMensualDias(raw: 2)}
    static var miercoles : PCMensualDias {return PCMensualDias(raw: 3)}
    static var jueves : PCMensualDias {return PCMensualDias(raw: 4)}
    static var viernes : PCMensualDias {return PCMensualDias(raw: 5)}
    static var sabado : PCMensualDias {return PCMensualDias(raw: 6)}
 }

struct PCMensualMeses {
    let raw : Int
    static var enero : PCMensualMeses {return PCMensualMeses(raw: 0)}
    static var febrero : PCMensualMeses {return PCMensualMeses(raw: 1)}
    static var marzo : PCMensualMeses {return PCMensualMeses(raw: 2)}
    static var abril : PCMensualMeses {return PCMensualMeses(raw: 3)}
    static var mayo : PCMensualMeses {return PCMensualMeses(raw: 4)}
    static var junio : PCMensualMeses {return PCMensualMeses(raw: 5)}
    static var julio : PCMensualMeses {return PCMensualMeses(raw: 6)}
    static var agosto : PCMensualMeses {return PCMensualMeses(raw: 7)}
    static var septiembre : PCMensualMeses {return PCMensualMeses(raw: 8)}
    static var octubre : PCMensualMeses {return PCMensualMeses(raw: 9)}
    static var noviembre : PCMensualMeses {return PCMensualMeses(raw: 10)}
    static var diciembre : PCMensualMeses {return PCMensualMeses(raw: 11)}

}


struct PCMensualSelectionMode {
    static let singleSelection = 0
    static let doubleSelection = 1
    static let randomSelection = 2
    static let dragSelection = 3
}

class PCMensualModel {
    var selectionMode : Int!
    var selectedItems : [Int]!
    var firstDay : PCMensualDias!
    var selectedDate : Date!
    var viewDate : Date!
    var columnasOscurecidas = [0, 6]
    
    var nombreDiasConstruidos = [String]()
    
    
    init(selectionMode: Int, selectedItems: [Int]) {
        self.selectionMode = selectionMode
        self.selectedItems = selectedItems
        self.firstDay = .domingo
        self.selectedDate = Date()
        self.viewDate = Date()
    }
    
    func construirNombreDias() {
        let a = Int(firstDay.raw / 7)
        
        nombreDiasConstruidos.removeAll()
        var offset = firstDay.raw - Int((a*7))
        for _ in 0...6 {
            nombreDiasConstruidos.append(String(arrayNombreDias[offset].prefix(3)))
            
            if offset > 5 {
                offset = 0
            } else {
                offset += 1
            }
            
            
        }
    }
    
 
}



class PCMensualValores {
    var fila : Int
    var columna : Int
    var antActSig : Int
    var dia : Int
    
    init(fila: Int, columna: Int, antActSig: Int, dia: Int) {
        self.fila = fila
        self.columna = columna
        self.antActSig = antActSig
        self.dia = dia
    }
}

