//
//  dataModelMensual.swift
//  calendario3_1
//
//  Created by David Diego Gomez on 17/1/18.
//  Copyright © 2018 David Diego Gomez. All rights reserved.
//

import Foundation
import UIKit

extension CalendarioMensual {
    struct atributoDePantalla {
        static var altoTitulo : CGFloat!
    }
    
    struct _meses {
        var labelMes = UILabel()
        var fondoMes = UIImageView()
        var labelsDias = [UILabel]()
        
    }
    
    class _datos {
       
        var labelTitulo : UILabel!
        var meses = [_meses]()
        
    }
    
    struct _fuentes {
        var fuenteNombreMes = UIFont(name: "Avenir-Medium", size: 19)!
        var colorNombreMes = UIColor.white
        var fuenteTitulo = UIFont(name: "Avenir-Medium", size: 17)!
        
    }
    
   
    
}
