//
//  dibujosMensual.swift
//  calendario3_1
//
//  Created by David Diego Gomez on 17/1/18.
//  Copyright © 2018 David Diego Gomez. All rights reserved.
//

import Foundation
import UIKit

extension CalendarioMensual {
    func dibujarCalendarioMensual() {
        for i in subviews {
            i.removeFromSuperview()
        }
        
        let viewCueporTitulo = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: atributoDePantalla.altoTitulo))
        viewCueporTitulo.backgroundColor = UIColor.blue.withAlphaComponent(1)
        addSubview(viewCueporTitulo)
        
        datos.labelTitulo = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: atributoDePantalla.altoTitulo))
        datos.labelTitulo.text = "hola"
        datos.labelTitulo.font = atributosPantalla.modoMensual.fonts.tituloFont
        datos.labelTitulo.textAlignment = .center
        datos.labelTitulo.textColor = atributosPantalla.modoMensual.fonts.tituloColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(tituloTapped(sender:)))
        tap.numberOfTapsRequired = 1
        datos.labelTitulo.isUserInteractionEnabled = true
        datos.labelTitulo.addGestureRecognizer(tap)
        addSubview(datos.labelTitulo)
        
        let viewCuerpoContenedorMeses = UIView()
        viewCuerpoContenedorMeses.backgroundColor = UIColor.cyan.withAlphaComponent(1)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(sender:)))
        swipeLeft.direction = .left
        viewCuerpoContenedorMeses.addGestureRecognizer(swipeLeft)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(sender:)))
        swipeRight.direction = .right
        viewCuerpoContenedorMeses.addGestureRecognizer(swipeRight)
        
        addSubview(viewCuerpoContenedorMeses)
        
        viewCuerpoContenedorMeses.translatesAutoresizingMaskIntoConstraints = false
        viewCuerpoContenedorMeses.topAnchor.constraint(equalTo: viewCueporTitulo.bottomAnchor).isActive = true
        viewCuerpoContenedorMeses.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        viewCuerpoContenedorMeses.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        viewCuerpoContenedorMeses.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        
        
        //dibujo los meses en el interior de viewCuerpoContenedorMeses
        var arrayDeMeses = [UIImageView]()
        var stacks = [UIStackView]()
        
        datos.meses.removeAll()
        
            // Download file or perform expensive task
        
        for columna in 0 ... 3 {
            arrayDeMeses.removeAll()
            for fila in 0 ... 2 {
                let nuevoMes = UIImageView(frame: CGRect.zero)
                nuevoMes.backgroundColor = UIColor.clear
                nuevoMes.layer.borderColor = UIColor.black.withAlphaComponent(1).cgColor
                nuevoMes.layer.borderWidth = 1
                
                //let d = drand48()
                //nuevoMes.alpha = CGFloat(d)
                let posicion = (fila + (columna * 3)) + 1
                nuevoMes.tag = posicion
                nuevoMes.isUserInteractionEnabled = true
                let tapElegiMes = UITapGestureRecognizer(target: self, action: #selector(self.mesTapped(sender:)))
                tapElegiMes.numberOfTapsRequired = 1
                nuevoMes.addGestureRecognizer(tapElegiMes)
                
                //agrego imagenes dentro de cada mes, label titulo mes, y label numeros
                let labelTituloMes = UILabel()
                
                let mesNombre = MESES[posicion]
                if let formaCorta = mesNombre?.prefix(3) {
                    labelTituloMes.text = String(formaCorta)
                }
                
                labelTituloMes.textAlignment = .center
                labelTituloMes.textColor = UIColor.black
                labelTituloMes.font = atributosPantalla.modoMensual.fonts.nombreMesesFont
                labelTituloMes.textColor = atributosPantalla.modoMensual.fonts.nombreMesesColor
                nuevoMes.addSubview(labelTituloMes)
                labelTituloMes.translatesAutoresizingMaskIntoConstraints = false
                labelTituloMes.topAnchor.constraint(equalTo: nuevoMes.topAnchor).isActive = true
                labelTituloMes.bottomAnchor.constraint(equalTo: nuevoMes.bottomAnchor).isActive = true
                labelTituloMes.rightAnchor.constraint(equalTo: nuevoMes.rightAnchor).isActive = true
                labelTituloMes.leftAnchor.constraint(equalTo: nuevoMes.leftAnchor).isActive = true
                
                arrayDeMeses.append(nuevoMes)

                var nuevaEstructura = _meses()
                nuevaEstructura.fondoMes = nuevoMes
                nuevaEstructura.labelMes = labelTituloMes
                self.datos.meses.append(nuevaEstructura)
/*
                DispatchQueue.main.async {
                    let dias = recuadroConDias()
                    dias.mesRequerido = posicion
                    dias.añoRequerido = self.añoEnPantalla
                    nuevoMes.addSubview(dias)
                    dias.translatesAutoresizingMaskIntoConstraints = false
                    dias.topAnchor.constraint(equalTo: nuevoMes.topAnchor).isActive = true
                    dias.bottomAnchor.constraint(equalTo: nuevoMes.bottomAnchor).isActive = true
                    dias.rightAnchor.constraint(equalTo: nuevoMes.rightAnchor).isActive = true
                    dias.leftAnchor.constraint(equalTo: nuevoMes.leftAnchor).isActive = true

                

                }
*/
 
 
            }
            let stacksFila = UIStackView(arrangedSubviews: arrayDeMeses)
            stacksFila.axis = .horizontal
            stacksFila.alignment = .fill
            stacksFila.distribution = .fillEqually
            stacksFila.spacing = -1
            
            stacks.append(stacksFila)
        }
        
         
        let stackGeneral = UIStackView(arrangedSubviews: stacks)
        stackGeneral.axis = .vertical
        stackGeneral.alignment = .fill
        stackGeneral.distribution = .fillEqually
        stackGeneral.spacing = -1
        
        viewCuerpoContenedorMeses.addSubview(stackGeneral)
        stackGeneral.translatesAutoresizingMaskIntoConstraints = false
        stackGeneral.topAnchor.constraint(equalTo: viewCuerpoContenedorMeses.topAnchor).isActive = true
        stackGeneral.bottomAnchor.constraint(equalTo: viewCuerpoContenedorMeses.bottomAnchor).isActive = true
        stackGeneral.rightAnchor.constraint(equalTo: viewCuerpoContenedorMeses.rightAnchor).isActive = true
        stackGeneral.leftAnchor.constraint(equalTo: viewCuerpoContenedorMeses.leftAnchor).isActive = true

        
        
    }
    
   
    
}
