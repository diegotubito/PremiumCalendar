//
//  acciones.swift
//  calendario2
//
//  Created by David Diego Gomez on 15/1/18.
//  Copyright © 2018 David Diego Gomez. All rights reserved.
//

import Foundation
import UIKit

extension CalendarioDiario {
    @objc func botonCerrarPresionado() {
        print("boton presionado")
        self.delegateDiario?.diaTappedDelegate(fecha: fechaSeleccionada)
        if configuracion.cerrarBotonEliminaCalendario {
            animarCerrarCalendario()
        }
       
    }
    
    @objc func tituloPresionado() {
        print("titulo presionado")
        self.delegateDiario?.tituloTappedDelegate(fecha: fechaEnPantalla)
        
    }
    
    @objc func tappedDia(_ sender: UITapGestureRecognizer) {

        
        
        print("toco un dia \(String(describing: sender.view?.tag))")
   
        let maximo = cuantosDiasTieneElMes(fecha: fechaEnPantalla)
        let diaInicial = queDiaEmpiezaElMes(fecha: fechaEnPantalla)
        
        animarSeleccion(layer: datos.viewDias[(sender.view?.tag)!].labelDia.layer)
        
        
        let x = (sender.view?.tag)! - diaInicial + 2
        if x > 0 && x <= maximo {
            print("ok, armo la fecha")
            
            let dia = String(x)
            let mes = String(mesDeLaFecha(fecha: fechaEnPantalla))
            let año = String(añoDeLaFecha(fecha: fechaEnPantalla))
            let fechaString = dia + "-" + mes + "-" + año
            let fecha = stringDate(fecha: fechaString , formato: FECHA)
            
            fechaSeleccionada = fecha
            
            self.delegateDiario?.diaTappedDelegate(fecha: fechaSeleccionada)
            
     
            
        } else {
            
            if x <= 0 {
                //si toque un dia del mes anterior
               
                swipeRight(nil)
                let maximo = cuantosDiasTieneElMes(fecha: fechaEnPantalla)

                let aux = x + maximo
                
                let dia = String(aux)
                let mes = String(mesDeLaFecha(fecha: fechaEnPantalla))
                let año = String(añoDeLaFecha(fecha: fechaEnPantalla))
                let fechaString = dia + "-" + mes + "-" + año
                let fecha = stringDate(fecha: fechaString , formato: FECHA)
                print("dia fuera del mes acutal fecha = \(fecha)")
                
                fechaEnPantalla = fecha
                fechaSeleccionada = fecha
             
    
            } else {
                //si toque un dia del mes posterior
                let maximo = cuantosDiasTieneElMes(fecha: fechaEnPantalla)
                swipeLeft(nil)
                
                let aux = x - maximo
                
                let dia = String(aux)
                let mes = String(mesDeLaFecha(fecha: fechaEnPantalla))
                let año = String(añoDeLaFecha(fecha: fechaEnPantalla))
                let fechaString = dia + "-" + mes + "-" + año
                let fecha = stringDate(fecha: fechaString , formato: FECHA)
                print("dia fuera del mes acutal aux = \(aux)")
                
                fechaSeleccionada = fecha
                fechaEnPantalla = fecha
            }
        }
      updateValues()
        
    }
   
    
    @objc func swipeRight(_ sender: UISwipeGestureRecognizer?) {
        print("swipe Right")
        
        
        let date = Calendar.current.date(byAdding: .month, value: -1, to: fechaEnPantalla)
        fechaEnPantalla = date!
        animarSwipeDerecho(label: datos.labelTitulo)
        
        for i in datos.viewDias {
            temblar(layer: i.labelDia.layer)
        }
        
        activarAnimaciones()
        
        updateValues()
    }
    
    
    @objc func swipeLeft(_ sender:UISwipeGestureRecognizer?) {
        print("swipe left")
       
       
        let date = Calendar.current.date(byAdding: .month, value: 1, to: fechaEnPantalla)
        fechaEnPantalla = date!
        
        animarSwipeIzquierdo(label: datos.labelTitulo)
       
        for i in datos.viewDias {
            temblar(layer: i.labelDia.layer)
        }
        
        activarAnimaciones()
        
        updateValues()
    }
    
  
    
    
}
