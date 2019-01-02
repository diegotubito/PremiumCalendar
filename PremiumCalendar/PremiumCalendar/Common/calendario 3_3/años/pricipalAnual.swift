//
//  pricipal.swift
//  calendario3_1
//
//  Created by David Diego Gomez on 16/1/18.
//  Copyright © 2018 David Diego Gomez. All rights reserved.
//

import Foundation
import UIKit

extension Calendario {
    
    
    func dibujarCalendarioAnual() {
        
        let dibujoViewAño = UIView(frame: frame)
        dibujoViewAño.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        dibujoViewAño.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(azulTapped(sender:)))
        tap.numberOfTapsRequired = 1
        dibujoViewAño.addGestureRecognizer(tap)
        
        
        addSubview(dibujoViewAño)
        
        
    }
    
    
    @objc func azulTapped(sender : UITapGestureRecognizer) {
        print("fondo rojo tapped")
        calendarioActual = _calendario.diario
    }
    
    
    
}

