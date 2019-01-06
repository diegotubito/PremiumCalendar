//
//  calendario4.swift
//  calendario3_3
//
//  Created by David Diego Gomez on 16/1/18.
//  Copyright © 2018 David Diego Gomez. All rights reserved.
//

import Foundation
import UIKit

struct _datoDot {
    var texto : String?
    var color : UIColor?
}

protocol calendarioDelegate {
    func tengoLaFecha(fecha: Date)
}

class Calendario : UIView {
    var delegate : calendarioDelegate?
    
    var bordeRadio : CGFloat = 0 {
        didSet {
            layer.cornerRadius = bordeRadio
        }
    }
    var anchoBorde : CGFloat = 0 {
        didSet {
            layer.borderWidth = anchoBorde
        }
    }
    var colorBorde : UIColor = UIColor.black {
        didSet {
            layer.borderColor = colorBorde.cgColor
        }
    }
    
    var isMasksToBounds : Bool = false {
        didSet {
            layer.masksToBounds = isMasksToBounds
        }
    }
    
    var colorSubtitulo : UIColor = UIColor.white {
        didSet {
            atributosPantalla.modoDia.fonts.subtituloColor = colorSubtitulo
        }
    }
    
    var colorNumeros : UIColor = UIColor.black {
        didSet {
            atributosPantalla.modoDia.fonts.numeroDiasColor = colorNumeros
        }
    }
    
    
    
    struct _misCalendarios {
        static var calendarioDiario : CalendarioDiario!
        static var calendarioMensual : CalendarioMensual!
    }
    
    struct _calendario {
        static let diario = 0
        static let mensual = 1
        static let anual = 2
    }
    
    var fechaSeleccionada = Date()
    var fechaEnPantalla = Date()
    var isMinimized = false
    var posicionMinimizadaX : CGFloat!
    var posicionMinimizadaY : CGFloat!
    var posicionMaximizadaX : CGFloat!
    var posicionMaximizadaY : CGFloat!
    var relacionCompresion : CGFloat = 0.2

    var listadoDeFechasDotA : [String : _datoDot]?
    var listadoDeFechasDotB : [String : _datoDot]?
    var listadoTitulosDias : [String : _datoDot]?

    var hoyLabel : UILabel!
    
    var calendarioActual = _calendario.diario {
        didSet {
            updateView()
            print(oldValue)
        }
    }
    
    func updateView() {
        print("redibujar...")
        print("cantidad de subViews: \(subviews.count)")
        for i in subviews {
            
            i.removeFromSuperview()
        }
    
        maquinaDeEstado()
            
    }

    
    override init(frame: CGRect) {
        super .init(frame: frame)
        posicionMaximizadaX = 0
        posicionMaximizadaY = safeAreaInsets.top
        posicionMinimizadaX = center.x
        posicionMinimizadaY = center.y
        
        atributosDias()
        atributosMensual()
    }
    
    func maquinaDeEstado() {
        switch calendarioActual {
        case _calendario.diario:
            if _misCalendarios.calendarioDiario != nil {
                for i in _misCalendarios.calendarioDiario.subviews {
                    i.removeFromSuperview()
                }
            }
           
            
            _misCalendarios.calendarioDiario = CalendarioDiario(frame: self.frame)
          
         
            _misCalendarios.calendarioDiario.colorSubtitulo = UIColor.lightGray
            _misCalendarios.calendarioDiario.delegateDiario = self
            
            _misCalendarios.calendarioDiario.fechaSeleccionada = self.fechaSeleccionada
            _misCalendarios.calendarioDiario.fechaEnPantalla = self.fechaEnPantalla
            self.addSubview(_misCalendarios.calendarioDiario)
            
            
            _misCalendarios.calendarioDiario.listadoTitulosDias = listadoTitulosDias
            _misCalendarios.calendarioDiario.listadoDeFechasDotA = listadoDeFechasDotA
            _misCalendarios.calendarioDiario.listadoDeFechasDotB = listadoDeFechasDotB
        
            
            _misCalendarios.calendarioDiario.translatesAutoresizingMaskIntoConstraints = false
            _misCalendarios.calendarioDiario.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            _misCalendarios.calendarioDiario.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            _misCalendarios.calendarioDiario.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
            _misCalendarios.calendarioDiario.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            
            DispatchQueue.main.async {
                if self.isMinimized {
                    self.minimizar(animated: false)
                    
                    //el boton solo se usa una vez, en modo minimizado.
                    self.agregarBotonMiCalendario()
                }
            }
            
       
            transicionCalendarios2(layer: layer)
  
            break
        case _calendario.mensual:
            if _misCalendarios.calendarioMensual != nil {
                for i in _misCalendarios.calendarioMensual.subviews {
                    i.removeFromSuperview()
                }
            }
        
                _misCalendarios.calendarioMensual = CalendarioMensual(frame: self.frame)
            
                _misCalendarios.calendarioMensual.delegateMensual = self
                _misCalendarios.calendarioMensual.añoEnPantalla = añoDeLaFecha(fecha: self.fechaEnPantalla)
                _misCalendarios.calendarioMensual.highlightedYear = añoDeLaFecha(fecha: self.fechaEnPantalla)
                _misCalendarios.calendarioMensual.highlightedMonth = mesDeLaFecha(fecha: self.fechaEnPantalla)
                self.addSubview(_misCalendarios.calendarioMensual)
    
                _misCalendarios.calendarioMensual.translatesAutoresizingMaskIntoConstraints = false
                _misCalendarios.calendarioMensual.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
                _misCalendarios.calendarioMensual.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
                _misCalendarios.calendarioMensual.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
                _misCalendarios.calendarioMensual.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                

            transicionCalendarios2(layer: layer)
  
            break
        case _calendario.anual:
        
            self.dibujarCalendarioAnual()
        

            break
        default:
            print("error")
            break
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func agregarBotonMiCalendario() {
        let boton = UIButton()
        boton.addTarget(self, action: #selector(self.calendarioPresionado), for: .touchUpInside)
        addSubview(boton)

        
        
        boton.translatesAutoresizingMaskIntoConstraints = false
        boton.topAnchor.constraint(equalTo: topAnchor).isActive = true
        boton.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        boton.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        boton.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
    }
    
    @objc func calendarioPresionado(sender: UIButton) {
        sender.removeFromSuperview()
        print("voy a maximizar")
        //DispatchQueue.main.async {
            self.maximizar(animated: true)

        //}
    }
}

//delegates de calendarioDiario


extension Calendario: calendarioDiarioDelegate {
    
    func tituloTappedDelegate(fecha: Date) {
        fechaEnPantalla = fecha
        calendarioActual = _calendario.mensual
    }
    
    
    func diaTappedDelegate(fecha: Date) {
        print(DateString(fecha: fecha, formato: FECHA))
        fechaSeleccionada = fecha
        self.delegate?.tengoLaFecha(fecha: fechaSeleccionada)
        print("voy a minimizar")
        //  DispatchQueue.main.async {
        self.minimizar(animated: true)
        self.agregarBotonMiCalendario()
        
        //  }
    }
    
    func fechaEnPantallaModificada(fecha: Date) {
        fechaEnPantalla = fecha
    }
    
}
 


//delegates de calendarioMensual
extension Calendario: calendarioMensualDelegate {
    func mesAñoSeleccionado(mes: Int, año: Int) {
        // creo la fecha en pantalla
        let stringFecha = "1-" + String(mes) + "-" + String(año)
        fechaEnPantalla = stringDate(fecha: stringFecha, formato: FECHA)
        
        calendarioActual = _calendario.diario
    }
    
    func cambiarCalendarioMensual() {
        //calendarioActual = _calendario.anual
    }
    
    
}
