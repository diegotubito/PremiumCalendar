//
//  dataModel.swift
//  calendario2
//
//  Created by David Diego Gomez on 14/1/18.
//  Copyright © 2018 David Diego Gomez. All rights reserved.
//

import Foundation
import UIKit

extension CalendarioDiario {
    
    
    struct configuracion {
        static var botonCerrarDisable = false
        static var cerrarBotonEliminaCalendario = false
    }
    
    class _datosVariable {
        var labelTitulo = UILabel()
        var botonCerrar = UIButton()
        
        class _viewsDias {
            var labelDia = UILabel()
            var labelDotA = UILabel()
            var labelDotB = UILabel()
            var fondo = UIImageView()
            var labelTituloDia = UILabel()
        }
        var viewDias = [_viewsDias]()
        
    }
    
    
}
