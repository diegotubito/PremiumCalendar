//
//  dibujos.swift
//  calendario2
//
//  Created by David Diego Gomez on 14/1/18.
//  Copyright © 2018 David Diego Gomez. All rights reserved.
//

import Foundation
import UIKit


extension CalendarioDiario {
    func dibujarViewTitulo() -> UIView{
        //primer view, titulo: "Enero 2018"
        //compuesto por: imageView, label, button.
        let miView = UIView(frame: CGRect(x: 0, y: 0, width: atributosPantalla.modoDia.ancho, height: atributosPantalla.modoDia.altoTitulo))
     
        //el fondo del titulo
        let fondoTitulo = UIImageView(frame: CGRect(x: 0, y: 0, width: atributosPantalla.modoDia.ancho, height: atributosPantalla.modoDia.altoTitulo))
        // fondoTitulo.image = #imageLiteral(resourceName: "fondo")
        fondoTitulo.backgroundColor = UIColor.black.withAlphaComponent(1)
        miView.addSubview(fondoTitulo)
        
        
        
       
        
      
        //el label del titulo
        datos.labelTitulo = UILabel(frame: CGRect(x: 5, y: 0, width: atributosPantalla.modoDia.ancho - 5, height: atributosPantalla.modoDia.altoTitulo))
        datos.labelTitulo.text = "prueba"
        datos.labelTitulo.textColor = atributosPantalla.modoDia.fonts.tituloColor
        datos.labelTitulo.font = atributosPantalla.modoDia.fonts.tituloFont
        datos.labelTitulo.textAlignment = .center
        datos.labelTitulo.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tituloPresionado))
        tap.numberOfTapsRequired = 1
        datos.labelTitulo.addGestureRecognizer(tap)
 
        miView.addSubview(datos.labelTitulo)
        datos.labelTitulo.translatesAutoresizingMaskIntoConstraints = false
        datos.labelTitulo.topAnchor.constraint(equalTo: miView.topAnchor).isActive = true
        datos.labelTitulo.bottomAnchor.constraint(equalTo: miView.bottomAnchor).isActive = true
        datos.labelTitulo.rightAnchor.constraint(equalTo: miView.rightAnchor).isActive = true
        datos.labelTitulo.leftAnchor.constraint(equalTo: miView.leftAnchor).isActive = true
        
  
        
        
        //boton cerrar
        let altoBoton = CGFloat(atributosPantalla.modoDia.altoTitulo) * 0.6
        let diferencia = (CGFloat(atributosPantalla.modoDia.altoTitulo) - altoBoton) / 2
        datos.botonCerrar = UIButton(frame: CGRect(x: diferencia, y: diferencia, width: altoBoton, height: altoBoton))
        let imagenBotonCerrar = UIImage(named: "botonRedondo")
        datos.botonCerrar.setBackgroundImage(imagenBotonCerrar, for: .normal)
        datos.botonCerrar.addTarget(self, action: #selector(botonCerrarPresionado), for: .touchUpInside)
        
        miView.addSubview(datos.botonCerrar)
   
   
        
        //agrego lo creado
        return miView
    }
    
  
    
    
    
    func dibujarSubtitulos() -> UIView{
        //segundo view: nombre de los días
        let miView = UIImageView(frame: CGRect(x: 0, y: viewTitulo.frame.maxY, width: atributosPantalla.modoDia.ancho, height: atributosPantalla.modoDia.altoSubtitulo))
        miView.layer.borderColor = UIColor.lightGray.cgColor
        miView.layer.borderWidth = 1
        
        let imagenDeFondoNombreDias = UIImageView(frame: CGRect(x: 0, y: 0, width: atributosPantalla.modoDia.ancho, height: atributosPantalla.modoDia.altoSubtitulo))
        imagenDeFondoNombreDias.backgroundColor = UIColor.blue.withAlphaComponent(1)
        miView.addSubview(imagenDeFondoNombreDias)
        
        //labeles: lun, mar, mie, jue, vie, sab, dom
        var labeles = [UILabel]()
        labeles.append(crearLabel(texto: "dom"))
        labeles.append(crearLabel(texto: "lun"))
        labeles.append(crearLabel(texto: "mar"))
        labeles.append(crearLabel(texto: "mié"))
        labeles.append(crearLabel(texto: "jue"))
        labeles.append(crearLabel(texto: "vie"))
        labeles.append(crearLabel(texto: "sáb"))
        
        
        
        //stack view
        
        let stackNombreDias = UIStackView(arrangedSubviews: labeles)
        miView.addSubview(stackNombreDias)
        
        stackNombreDias.translatesAutoresizingMaskIntoConstraints = false
        stackNombreDias.topAnchor.constraint(equalTo: miView.topAnchor).isActive = true
        stackNombreDias.bottomAnchor.constraint(equalTo: miView.bottomAnchor).isActive = true
        stackNombreDias.leftAnchor.constraint(equalTo: miView.leftAnchor).isActive = true
        stackNombreDias.rightAnchor.constraint(equalTo: miView.rightAnchor).isActive = true
        stackNombreDias.axis = .horizontal
        stackNombreDias.alignment = .fill
        stackNombreDias.distribution = .fillEqually
        stackNombreDias.spacing = 5
        
        return miView
    }
    
    private func crearLabel(texto: String) -> UILabel {
        let labelAux = UILabel()
        labelAux.textAlignment = .center
        labelAux.textColor = atributosPantalla.modoDia.fonts.subtituloColor
        labelAux.font = atributosPantalla.modoDia.fonts.subtituloFont
        labelAux.text = texto
        
        return labelAux
    }
    
    
    
    
    
    
    
    
    
    func dibujarViewDias() -> UIView {
        //view la parte de los dias
        let miView = UIView(frame: CGRect(x: 0, y: viewSubtitulo.frame.maxY, width: atributosPantalla.modoDia.ancho, height: frame.height - (atributosPantalla.modoDia.altoTitulo + atributosPantalla.modoDia.altoSubtitulo)))
        miView.backgroundColor = UIColor.cyan.withAlphaComponent(1)
       
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft(_:)))
        swipeLeft.direction = .left
        miView.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRight(_:)))
        swipeRight.direction = .right
        miView.addGestureRecognizer(swipeRight)
        
        //creo los dias y lo pongo en un stack
        var filaDias = [UIStackView]()
        var stacks = [UIStackView]()
        
        datos.viewDias.removeAll()
        
        for columna in 0 ... 5 {
           filaDias.removeAll()
            for fila in 0 ... 6 {
                
                //agrego un label
                let labelNumero = UILabel(frame: CGRect(x: 0, y: 0, width: atributosPantalla.modoDia.anchoDia, height: atributosPantalla.modoDia.altoDia))
                labelNumero.text = "p"
                labelNumero.textAlignment = .center
                let posicionEnArray = fila + (columna * 7)
                labelNumero.tag = posicionEnArray
                labelNumero.isUserInteractionEnabled = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(tappedDia(_:)))
                tap.numberOfTapsRequired = 1
                labelNumero.addGestureRecognizer(tap)
                
                let nuevoDato = CalendarioDiario._datosVariable._viewsDias()
                nuevoDato.labelDia = labelNumero
                

                var arrayDots = [UILabel]()
                
                if listadoTitulosDias != nil {
                    //agrego un dot, que es otro label
                    let labelTituloDia = UILabel(frame: CGRect(x: 0, y: atributosPantalla.modoDia.altoDia/6, width: atributosPantalla.modoDia.anchoDia, height: atributosPantalla.modoDia.altoDia))
                    labelTituloDia.numberOfLines = 1
        
                    labelTituloDia.font = atributosPantalla.modoDia.fonts.fontTituloDia
                    labelTituloDia.textAlignment = .center
                    
                    //labelNumero.addSubview(labelDot)
               //     arrayDots.append(labelTituloDia)
                    labelNumero.addSubview(labelTituloDia)
                    nuevoDato.labelTituloDia = labelTituloDia
                    labelTituloDia.translatesAutoresizingMaskIntoConstraints = false
                    labelTituloDia.topAnchor.constraint(equalTo: labelNumero.topAnchor).isActive = true
                 //   labelTituloDia.bottomAnchor.constraint(equalTo: labelNumero.bottomAnchor).isActive = true
                    labelTituloDia.rightAnchor.constraint(equalTo: labelNumero.rightAnchor).isActive = true
                    labelTituloDia.leftAnchor.constraint(equalTo: labelNumero.leftAnchor).isActive = true
                   labelTituloDia.heightAnchor.constraint(equalToConstant: atributosPantalla.modoDia.altoDia/3).isActive = true
                    
                    
                }
                if listadoDeFechasDotA != nil {
                    //agrego un dot, que es otro label
                    let labelDot = UILabel(frame: CGRect(x: 0, y: atributosPantalla.modoDia.altoDia/6, width: atributosPantalla.modoDia.anchoDia, height: atributosPantalla.modoDia.altoDia))
                    labelDot.text = "."
                    labelDot.font = atributosPantalla.modoDia.fonts.dotFont
                    labelDot.textAlignment = .center
                    //labelNumero.addSubview(labelDot)
                    nuevoDato.labelDotA = labelDot
                    arrayDots.append(labelDot)
                }
                if listadoDeFechasDotB != nil {
                    //agrego el segundo dot, que es otro label
                    let labelDot2 = UILabel(frame: CGRect(x: 0, y: atributosPantalla.modoDia.altoDia/6, width: atributosPantalla.modoDia.anchoDia, height: atributosPantalla.modoDia.altoDia))
                    labelDot2.text = "."
                    labelDot2.font = atributosPantalla.modoDia.fonts.dotFont
                    labelDot2.textAlignment = .center
                    //labelNumero.addSubview(labelDot2)
                    nuevoDato.labelDotB = labelDot2
                    arrayDots.append(labelDot2)
                }

                //agrupo los dots en un stack
                let stackDots = UIStackView(arrangedSubviews: arrayDots)
                stackDots.axis = .horizontal
                stackDots.alignment = .fill
                stackDots.distribution = .fillEqually
                stackDots.spacing = -5
                
                labelNumero.addSubview(stackDots)
                stackDots.translatesAutoresizingMaskIntoConstraints = false
                stackDots.topAnchor.constraint(equalTo: labelNumero.topAnchor).isActive = true
                stackDots.bottomAnchor.constraint(equalTo: labelNumero.bottomAnchor).isActive = true
                stackDots.leftAnchor.constraint(equalTo: labelNumero.leftAnchor).isActive = true
                stackDots.rightAnchor.constraint(equalTo: labelNumero.rightAnchor).isActive = true
                
                
                let stackDia = UIStackView(arrangedSubviews: [labelNumero])
                stackDia.axis = .vertical
                stackDia.alignment = .fill
                stackDia.distribution = .fillEqually
                
            
                
                datos.viewDias.append(nuevoDato)

                filaDias.append(stackDia)
            
  
            }
            let stackFila = UIStackView(arrangedSubviews: filaDias)
            stackFila.axis = .horizontal
            stackFila.alignment = .fill
            stackFila.distribution = .fillEqually
            stackFila.spacing = 0
            stacks.append(stackFila)
        }
        let stackGeneral = UIStackView(arrangedSubviews: stacks)
        stackGeneral.axis = .vertical
        stackGeneral.alignment = .fill
        stackGeneral.distribution = .fillEqually
        stackGeneral.spacing = 0
        
        
        miView.addSubview(stackGeneral)
        stackGeneral.translatesAutoresizingMaskIntoConstraints = false
        stackGeneral.topAnchor.constraint(equalTo: miView.topAnchor).isActive = true
        stackGeneral.bottomAnchor.constraint(equalTo: miView.bottomAnchor).isActive = true
        stackGeneral.rightAnchor.constraint(equalTo: miView.rightAnchor).isActive = true
        stackGeneral.leftAnchor.constraint(equalTo: miView.leftAnchor).isActive = true
        
        
        return miView
  
    }
    

}
