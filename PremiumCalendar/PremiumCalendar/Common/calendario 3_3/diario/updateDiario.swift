//
//  update.swift
//  calendario2
//
//  Created by David Diego Gomez on 15/1/18.
//  Copyright © 2018 David Diego Gomez. All rights reserved.
//

import Foundation
import UIKit

extension CalendarioDiario {
    func actualizarTitulo() {
        let numeroDelMes = mesDeLaFecha(fecha: fechaEnPantalla)
        let mesString = MESES[numeroDelMes]
        let numeroDelAño = añoDeLaFecha(fecha: fechaEnPantalla)
        datos.labelTitulo.text = mesString! + " " + String(numeroDelAño)
    }
    
    func actualizarDias() {
        
        let diaInicial = queDiaEmpiezaElMes(fecha: fechaEnPantalla)
        let maximo = cuantosDiasTieneElMes(fecha: fechaEnPantalla)

        //mes posterior
        let mesPosterior = Calendar.current.date(byAdding: .month, value: 1, to: fechaEnPantalla)

        //calculo maxmimo anterior
        let mesAnterior = Calendar.current.date(byAdding: .month, value: -1, to: fechaEnPantalla)
        let maximoAnterior = cuantosDiasTieneElMes(fecha: mesAnterior!)
        
        var colorTexto = UIColor()
        var fontTexto = UIFont()
        
        for i in 0 ... 41 {
            var x = i - diaInicial + 2
            
            datos.viewDias[i].labelDia.backgroundColor = UIColor.clear
            
            var datoDotA : _datoDot?
            var datoDotB : _datoDot?
            var datoTituloDia : _datoDot?
            
            if x < 1 {
                //los dias del mes anterior
                x = x + maximoAnterior
                
                let dia = x
                let mes = mesDeLaFecha(fecha: mesAnterior!)
                let año = añoDeLaFecha(fecha: mesAnterior!)
                var fechaString = String(dia) + "-" + String(mes) + "-" + String(año)
                let fechaDate = stringDate(fecha: fechaString, formato: FECHA)
                fechaString = DateString(fecha: fechaDate, formato: FECHA)
                
                if listadoTitulosDias != nil {
                    datoTituloDia = existeTituloDia(fecha: fechaString, listado: listadoTitulosDias!, forzarColor: UIColor.gray)
                }
                if listadoDeFechasDotA != nil {
                    datoDotA = existeTituloDia(fecha: fechaString, listado: listadoDeFechasDotA!, forzarColor: UIColor.gray)
                }
                if listadoDeFechasDotB != nil {
                    datoDotB = existeTituloDia(fecha: fechaString, listado: listadoDeFechasDotB!, forzarColor: UIColor.gray)
                }
                colorTexto = atributosPantalla.modoDia.fonts.numeroDiaMesAnteriorColor
                fontTexto = atributosPantalla.modoDia.fonts.numeroDiaMesAnteriorFont
                
            } else if x > maximo {
                //los dias del mes posterior
                x = x - maximo
                let dia = x
                let mes = mesDeLaFecha(fecha: mesPosterior!)
                let año = añoDeLaFecha(fecha: mesPosterior!)
                var fechaString = String(dia) + "-" + String(mes) + "-" + String(año)
                let fechaDate = stringDate(fecha: fechaString, formato: FECHA)
                fechaString = DateString(fecha: fechaDate, formato: FECHA)
                
                if listadoTitulosDias != nil {
                    datoTituloDia = existeTituloDia(fecha: fechaString, listado: listadoTitulosDias!, forzarColor: UIColor.gray)
                }
                
                if listadoDeFechasDotA != nil {
                    datoDotA = existeTituloDia(fecha: fechaString, listado: listadoDeFechasDotA!, forzarColor: UIColor.gray)
                }
                if listadoDeFechasDotB != nil {
                    datoDotB = existeTituloDia(fecha: fechaString, listado: listadoDeFechasDotB!, forzarColor: UIColor.gray)
                }
                colorTexto = atributosPantalla.modoDia.fonts.numeroDiaMesPosteriorColor
                fontTexto = atributosPantalla.modoDia.fonts.numeroDiaMesPosteriorFont
            } else {
                //los dias del mes actual
                
                let dia = x
                let mes = mesDeLaFecha(fecha: fechaEnPantalla)
                let año = añoDeLaFecha(fecha: fechaEnPantalla)
                var fechaString = String(dia) + "-" + String(mes) + "-" + String(año)
                let fechaDate = stringDate(fecha: fechaString, formato: FECHA)
                fechaString = DateString(fecha: fechaDate, formato: FECHA)
                
                if listadoTitulosDias != nil {
                    datoTituloDia = existeTituloDia(fecha: fechaString, listado: listadoTitulosDias!)
                }
                
                if listadoDeFechasDotA != nil {
                    datoDotA = existeTituloDia(fecha: fechaString, listado: listadoDeFechasDotA!)
                }
                if listadoDeFechasDotB != nil {
                    datoDotB = existeTituloDia(fecha: fechaString, listado: listadoDeFechasDotB!)
                }
                
                colorTexto = atributosPantalla.modoDia.fonts.numeroDiasColor
                fontTexto = atributosPantalla.modoDia.fonts.numeroDiasFont
                datos.viewDias[i].labelDia.layer.borderWidth = 0
                if esHoy(dia: x) {
                    //es hoy
                    colorTexto = atributosPantalla.modoDia.fonts.numeroDiaHoyColor
                    fontTexto = atributosPantalla.modoDia.fonts.numeroDiaHoyFont
                  //  datos.viewDias[i].labelDia.layer.borderWidth = 2
                    datos.viewDias[i].labelDia.layer.cornerRadius = 5
                    
                    animarHoy(layer: datos.viewDias[i].labelDia.layer)
                    if !animacion.animacionPalabraHoy.disabled {
                        mostrarPalabraHoy(label: datos.viewDias[i].labelDia)
                    }
                    //este bloque por si es hoy y encima es seleccion
                    if esFechaDeSeleccion(dia: x) {
                        //es la fecha seleccionada
                        colorTexto = atributosPantalla.modoDia.fonts.numeroDiaSeleccionColor
                        fontTexto = atributosPantalla.modoDia.fonts.numeroDiaSeleccionFont
                        datos.viewDias[i].labelDia.layer.cornerRadius = 5
                        datos.viewDias[i].labelDia.layer.masksToBounds = false
                        datos.viewDias[i].labelDia.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
                        
                    }
                    
                } else {
                
                    if esFechaDeSeleccion(dia: x) {
                        //es la fecha seleccionada
                        colorTexto = atributosPantalla.modoDia.fonts.numeroDiaSeleccionColor
                        fontTexto = atributosPantalla.modoDia.fonts.numeroDiaSeleccionFont
                        datos.viewDias[i].labelDia.layer.cornerRadius = 5
                        datos.viewDias[i].labelDia.layer.masksToBounds = true
                        datos.viewDias[i].labelDia.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
                        
                    }
                    
                }
                
            
                
                
            }
            
            
         
            if datoTituloDia != nil {
                datos.viewDias[i].labelTituloDia.text = datoTituloDia?.texto
                datos.viewDias[i].labelTituloDia.textColor = datoTituloDia?.color
            } else {
                datos.viewDias[i].labelTituloDia.text = ""
            }
            if datoDotB != nil {
                
                datos.viewDias[i].labelDotB.text = datoDotB?.texto
                datos.viewDias[i].labelDotB.textColor = datoDotB?.color
            } else {
                datos.viewDias[i].labelDotB.text = ""
            }
            if datoDotA != nil {
                
                datos.viewDias[i].labelDotA.text = datoDotA?.texto
                datos.viewDias[i].labelDotA.textColor = datoDotA?.color
            } else {
                datos.viewDias[i].labelDotA.text = ""
            }
            let numeroString = String(x)
            datos.viewDias[i].labelDia.text = numeroString
            datos.viewDias[i].labelDia.textColor = colorTexto
            datos.viewDias[i].labelDia.font = fontTexto
        }
    }
    
    func mostrarPalabraHoy(label: UILabel) {
        if hoyLabel != nil {
            hoyLabel.removeFromSuperview()
        }
        
        hoyLabel = UILabel()
        hoyLabel.text = "Hoy"
        hoyLabel.font = atributosPantalla.modoDia.fonts.hoyStringFont
        hoyLabel.textColor = atributosPantalla.modoDia.fonts.hoyStringColor
        hoyLabel.textAlignment = .center
        
        label.layer.masksToBounds = false
        label.addSubview(hoyLabel)
        hoyLabel.translatesAutoresizingMaskIntoConstraints = false
        hoyLabel.topAnchor.constraint(equalTo: label.topAnchor).isActive = true
        hoyLabel.bottomAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        hoyLabel.rightAnchor.constraint(equalTo: label.rightAnchor).isActive = true
        hoyLabel.leftAnchor.constraint(equalTo: label.leftAnchor).isActive = true
        
        
        animarPalabraHoy()
        
    }
    
    private func animarHoy() -> CASpringAnimation {
        let escalar = CASpringAnimation(keyPath: "transform.scale")
        escalar.damping = 10
        escalar.initialVelocity = -10
        escalar.duration = escalar.settlingDuration
        escalar.fromValue = 0.2
        escalar.toValue = 1
        escalar.duration = CACurrentMediaTime() + 0.66
        
        return escalar
    }
    
    private func esHoy(dia: Int) -> Bool{
        let mes = mesDeLaFecha(fecha: fechaEnPantalla)
        let año = añoDeLaFecha(fecha: fechaEnPantalla)
        
        
        let diaHoy = diaDeLaFecha(fecha: Date())
        let mesHoy = mesDeLaFecha(fecha: Date())
        let añoHoy = añoDeLaFecha(fecha: Date())
        
        if dia == diaHoy && mes == mesHoy && año == añoHoy
        {
            return true
        }
        return false
    }
    
    private func esFechaDeSeleccion(dia: Int) -> Bool{
        let mesElegido = mesDeLaFecha(fecha: fechaSeleccionada)
        let añoElegido = añoDeLaFecha(fecha: fechaSeleccionada)
        let diaElegido = diaDeLaFecha(fecha: fechaSeleccionada)
        
        let mesEnPantalla = mesDeLaFecha(fecha: fechaEnPantalla)
        let añoEnPantalla = añoDeLaFecha(fecha: fechaEnPantalla)
        if diaElegido == dia && mesEnPantalla == mesElegido && añoEnPantalla == añoElegido
        {
            return true
        }
        return false
    }
    
}
