//
//  titulos methods.swift
//  calendario3_3
//
//  Created by David Diego Gomez on 23/1/18.
//  Copyright © 2018 David Diego Gomez. All rights reserved.
//

import Foundation
import UIKit

extension Calendario {
  
    func existeTituloDia(fecha: String, listado: [String:_datoDot] ) -> _datoDot? {
        var datos : _datoDot?
        
        let filtered = listado.filter({ $0.key == fecha })
        datos = filtered[fecha]
        
        return datos
    }
    
    func existeTituloDia(fecha: String, listado: [String: _datoDot], forzarColor: UIColor) -> _datoDot? {
        var datos : _datoDot?
        
        let filtered = listado.filter({ $0.key == fecha })
        datos = filtered[fecha]
        datos?.color = forzarColor
        
        return datos
    }
 
}

