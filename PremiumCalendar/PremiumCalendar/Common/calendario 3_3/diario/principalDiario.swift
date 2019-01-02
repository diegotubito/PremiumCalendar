//
//  calendario3.swift
//  calendario2
//
//  Created by David Diego Gomez on 14/1/18.
//  Copyright © 2018 David Diego Gomez. All rights reserved.
//

import UIKit

protocol calendarioDiarioDelegate: class {
    func diaTappedDelegate(fecha: Date)
    func tituloTappedDelegate(fecha: Date)
}

class CalendarioDiario: Calendario {
    
    weak var delegateDiario : calendarioDiarioDelegate?

    var modoActual = modos.dias
    
    var datos = _datosVariable()

    var viewTitulo : UIView!
    var viewSubtitulo : UIView!
    var viewDias : UIView!
    
   // var dotsAjson: [[Int : Any]]?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
   
        DispatchQueue.main.async {
            self.inicializarValores()
            self.dibujarPantalla()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dibujarPantalla() {
        if modoActual == modos.dias {
            dibujarPantallaDias()
        }
    }
    
    private func dibujarPantallaDias() {
        for i in subviews {
            i.removeFromSuperview()
        }
        
        self.viewTitulo = self.dibujarViewTitulo()
        self.addSubview(self.viewTitulo)
        
        self.viewSubtitulo = self.dibujarSubtitulos()
        self.addSubview(self.viewSubtitulo)
        
        self.viewDias = self.dibujarViewDias()
        self.addSubview(self.viewDias)
        
        //si esta desabilitado remuevo el boton
        if configuracion.botonCerrarDisable {
            self.datos.botonCerrar.removeFromSuperview()
        }
    
        self.updateValues()
    }
    
    func updateValues() {
        actualizarTitulo()
        actualizarDias()
    }
    
    func inicializarValores() {
        datos.labelTitulo.removeFromSuperview()
        datos.botonCerrar.removeFromSuperview()
        
        activarAnimaciones()
    }
    
    func activarAnimaciones() {
        if hoyLabel != nil {
            hoyLabel.layer.removeAllAnimations()
        }
        animacion.efectoHoy.disabled = false
        animacion.animacionPalabraHoy.disabled = false
    }
   

}
