//
//  dataModel.swift
//  calendario3_3
//
//  Created by David Diego Gomez on 22/1/18.
//  Copyright © 2018 David Diego Gomez. All rights reserved.
//

import Foundation
import UIKit

extension Calendario {
 
    struct modos {
        static let dias = 0
        static let meses = 1
        static let años = 2
    }
    
    
    func atributosDias() {
        atributosPantalla.modoDia.alto = frame.height
        atributosPantalla.modoDia.ancho = frame.width
        atributosPantalla.modoDia.altoTitulo = atributosPantalla.modoDia.alto / 7
        atributosPantalla.modoDia.ancho = frame.width
        atributosPantalla.modoDia.altoSubtitulo = atributosPantalla.modoDia.altoTitulo * 0.7
        atributosPantalla.modoDia.anchoSubtitulo = frame.width
        atributosPantalla.modoDia.anchoDia = atributosPantalla.modoDia.ancho / 7
        atributosPantalla.modoDia.altoDia = (atributosPantalla.modoDia.alto - (atributosPantalla.modoDia.altoTitulo + atributosPantalla.modoDia.altoSubtitulo)) / 6
        
        //fonts
        atributosPantalla.modoDia.fonts.tituloFont = UIFont(name: "Avenir-Medium", size: 17)!
        atributosPantalla.modoDia.fonts.tituloColor = UIColor.white
        atributosPantalla.modoDia.fonts.subtituloFont = UIFont(name: "Avenir-Light", size: 12)!
        
        atributosPantalla.modoDia.fonts.subtituloColor = colorSubtitulo
        atributosPantalla.modoDia.fonts.numeroDiaHoyFont = UIFont(name: "Avenir-Medium", size: 21)!
        atributosPantalla.modoDia.fonts.numeroDiaHoyColor = UIColor.yellow
        atributosPantalla.modoDia.fonts.numeroDiasFont = UIFont(name: "Avenir-Light", size: 17)!
        atributosPantalla.modoDia.fonts.numeroDiasColor = colorNumeros
        atributosPantalla.modoDia.fonts.numeroDiaSeleccionFont = UIFont(name: "Avenir-Medium", size: 17)!
        atributosPantalla.modoDia.fonts.numeroDiaSeleccionColor = UIColor.white
        atributosPantalla.modoDia.fonts.numeroDiaSeleccionColorFondo = UIColor.gray.withAlphaComponent(0.5)
        atributosPantalla.modoDia.fonts.numeroDiaMesAnteriorFont = UIFont(name: "Avenir-Light", size: 17)!
        atributosPantalla.modoDia.fonts.numeroDiaMesAnteriorColor = UIColor.gray
        atributosPantalla.modoDia.fonts.numeroDiaMesPosteriorFont = UIFont(name: "Avenir-Light", size: 17)!
        atributosPantalla.modoDia.fonts.numeroDiaMesPosteriorColor = UIColor.gray
        
        atributosPantalla.modoDia.fonts.hoyStringFont = UIFont(name: "Chalkduster", size: 12)!
        atributosPantalla.modoDia.fonts.hoyStringColor = UIColor.blue.withAlphaComponent(0.6)
        
        atributosPantalla.modoDia.fonts.dotFont = UIFont(name: "Avenir-Medium", size: 44)!
        atributosPantalla.modoDia.fonts.colorDotsA = UIColor.green
        atributosPantalla.modoDia.fonts.colorDotsB = UIColor.red
        atributosPantalla.modoDia.fonts.fontTituloDia = UIFont(name: "Chalkduster", size: 7)!
        atributosPantalla.modoDia.fonts.colorTituloDia = UIColor.black
    }
   
    func atributosMensual() {
        atributosPantalla.modoMensual.fonts.nombreMesesColor = UIColor.black
        atributosPantalla.modoMensual.fonts.nombreMesesFont = UIFont(name: "Avenir-Medium", size: 19)!
        atributosPantalla.modoMensual.fonts.tituloFont = UIFont(name: "Avenir-Medium", size: 17)!
        atributosPantalla.modoMensual.fonts.tituloColor = UIColor.white
        
    }
    
    struct atributosPantalla {
        struct modoMensual {
            struct fonts {
                static var nombreMesesFont = UIFont()
                static var nombreMesesColor = UIColor()
                static var tituloFont = UIFont()
                static var tituloColor = UIColor()
            }
        }
        struct modoDia {
            static var ancho = CGFloat()
            static var alto = CGFloat()
            static var anchoTitulo = CGFloat()
            static var altoTitulo = CGFloat()
            static var anchoSubtitulo = CGFloat()
            static var altoSubtitulo =  CGFloat()
            static var anchoDia = CGFloat()
            static var altoDia = CGFloat()
            
            struct fonts {
                static var tituloFont = UIFont()
                static var tituloColor = UIColor()
                static var subtituloFont = UIFont()
                static var subtituloColor = UIColor()
                static var numeroDiasFont = UIFont()
                static var numeroDiasColor = UIColor()
                static var numeroDiaSeleccionFont = UIFont()
                static var numeroDiaSeleccionColor = UIColor()
                static var numeroDiaHoyFont = UIFont()
                static var numeroDiaHoyColor = UIColor()
                static var numeroDiaSeleccionColorFondo = UIColor()
                
                static var numeroDiaMesAnteriorFont = UIFont()
                static var numeroDiaMesAnteriorColor = UIColor()
                static var numeroDiaMesPosteriorFont = UIFont()
                static var numeroDiaMesPosteriorColor = UIColor()
                
                static var hoyStringFont = UIFont()
                static var hoyStringColor = UIColor()
                
                static var dotFont = UIFont()
                static var colorDotsA = UIColor()
                static var colorDotsB = UIColor()
                static var colorTituloDia = UIColor()
                static var fontTituloDia = UIFont()
                
            }
        }
        
    }
    
    struct animacion {
        struct efectoSeleccionDeMes {
            static let nombre = "efecto seleccion de mes"
            static var disabled = false
        }
        struct efectoHoy {
            static let nombre = "efecto dia de hoy"
            static var disabled = false
        }
        struct cerrarCalendario {
            static let nombre = "cerrar calendario"
            static var disabled = false
        }
        struct animacionPalabraHoy {
            static let nombre = "animacion palabra hoy"
            static var disabled = false
        }
    }
}
