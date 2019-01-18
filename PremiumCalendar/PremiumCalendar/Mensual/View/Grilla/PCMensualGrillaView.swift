//
//  File.swift
//  PremiumCalendar
//
//  Created by David Diego Gomez on 13/1/19.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import UIKit

extension PCMensualCustomView {
    func dibujarGrilla() {
        tamañoHeader = (frame.height / 1.5) * factorDimension
        tamañoFontDiaDeLaSemana = frame.height/12 * factorDimension
        
        for i in self.subviews {
            i.removeFromSuperview()
        }
        
        let stackGrilla = UIStackView()
        
        let header = dibujarHeader()
        stackGrilla.addArrangedSubview(header)
        
        let diasDeLaSemana = dibujarDiasDeLaSemana()
        stackGrilla.addArrangedSubview(diasDeLaSemana)
        
        let cuerpo = dibujarCuerpo()
        stackGrilla.addArrangedSubview(cuerpo)
        
        stackGrilla.alignment = .fill
        stackGrilla.distribution = .fill
        stackGrilla.spacing = 0
        stackGrilla.axis = .vertical
        
        addSubview(stackGrilla)
        
        stackGrilla.translatesAutoresizingMaskIntoConstraints = false
        
        let a1 = NSLayoutConstraint(item: stackGrilla, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let a2 = NSLayoutConstraint(item: stackGrilla, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let a3 = NSLayoutConstraint(item: stackGrilla, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let a4 = NSLayoutConstraint(item: stackGrilla, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        self.addConstraints([a1, a2, a3, a4])
        
        diasDeLaSemana.translatesAutoresizingMaskIntoConstraints = false
        let d1 = NSLayoutConstraint(item: diasDeLaSemana, attribute: .leading, relatedBy: .equal, toItem: stackGrilla, attribute: .leading, multiplier: 1, constant: 0)
        let d2 = NSLayoutConstraint(item: diasDeLaSemana, attribute: .trailing, relatedBy: .equal, toItem: stackGrilla, attribute: .trailing, multiplier: 1, constant: 0)
        let d3 = NSLayoutConstraint(item: diasDeLaSemana, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (tamañoFontDiaDeLaSemana)*1.5 )
        stackGrilla.addConstraints([d1, d2, d3])
        
        header.translatesAutoresizingMaskIntoConstraints = false
        let h1 = NSLayoutConstraint(item: header, attribute: .leading, relatedBy: .equal, toItem: stackGrilla, attribute: .leading, multiplier: 1, constant: 0)
        let h2 = NSLayoutConstraint(item: header, attribute: .trailing, relatedBy: .equal, toItem: stackGrilla, attribute: .trailing, multiplier: 1, constant: 0)
        let h3 = NSLayoutConstraint(item: header, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: tamañoHeader)
        stackGrilla.addConstraints([h1, h2, h3])
        
        
    }
    
    func dibujarHeader() -> UIView{
        let rectangulo = UIView(frame: CGRect.zero)
        rectangulo.backgroundColor = UIColor.black
        
        return rectangulo
    }
    
    func dibujarDiasDeLaSemana() -> UIView {
        
        let rectangulo = UIView(frame: CGRect.zero)
        rectangulo.backgroundColor = UIColor.brown
        
        let containerStack = UIStackView()
        containerStack.alignment = .fill
        containerStack.distribution = .fillEqually
        containerStack.spacing = 0
        containerStack.axis = .horizontal
        
        for i in 0...6 {
            let lab = UILabel()
            lab.font = UIFont.systemFont(ofSize: tamañoFontDiaDeLaSemana)
            lab.text = viewModel.getNameDay(index: i)
            lab.textAlignment = .center
            containerStack.addArrangedSubview(lab)
        }
        
        rectangulo.addSubview(containerStack)
        
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        let c1 = NSLayoutConstraint(item: containerStack, attribute: .leading, relatedBy: .equal, toItem: rectangulo, attribute: .leading, multiplier: 1, constant: 0)
        let c2 = NSLayoutConstraint(item: containerStack, attribute: .trailing, relatedBy: .equal, toItem: rectangulo, attribute: .trailing, multiplier: 1, constant: 0)
        let c3 = NSLayoutConstraint(item: containerStack, attribute: .bottom, relatedBy: .equal, toItem: rectangulo, attribute: .bottom, multiplier: 1, constant: 0)
        let c4 = NSLayoutConstraint(item: containerStack, attribute: .top, relatedBy: .equal, toItem: rectangulo, attribute: .top, multiplier: 1, constant: 0)
        
        rectangulo.addConstraints([c1,c2,c3,c4])
        
        return rectangulo
    }
    
    func dibujarCuerpo() -> UIView {
        listaViews.removeAll()
        backgroundColor = fondoPlantilla
        let cuerpo = crearColumnas()
        return cuerpo
    }
    
    func crearColumnas() -> UIStackView {
        var arrayFilas = [UIStackView]()
        
        for index in 0...5 {
            let stackFila = crearFila(fila: index)
            arrayFilas.append(stackFila)
        }
        
        let columnas = UIStackView(arrangedSubviews: arrayFilas)
        columnas.alignment = .fill
        columnas.distribution = .fillEqually
        columnas.spacing = 1
        columnas.axis = .vertical
        
        return columnas
    }
    
    func crearFila(fila: Int) -> UIStackView {
        var viewsFila = [UIView]()
        
        for index in 0...6 {
            let nuevaView = PCDiaCustomView(frame: CGRect())
            let atributos = getDayAttibutes(fecha: viewModel.model.viewDate, fila: fila, columna: index)
            nuevaView.textoLabelCentral = String(atributos.numberDay)
            
            nuevaView.columna = index
            nuevaView.fila = fila
            nuevaView.colorLabelCentral = atributos.labelCentralColor
            nuevaView.fuenteLabelCentral = atributos.labelCentralFont
            nuevaView.bordeAncho = bordeAncho
            nuevaView.bordeColor = bordeColor
            nuevaView.fondoDia = fondoDia
            nuevaView.radio = radio
            nuevaView.delegate = self
      
            
            listaViews.append(nuevaView)
            viewsFila.append(nuevaView)
        }
        let stackFila = UIStackView(arrangedSubviews: viewsFila)
        stackFila.distribution = .fillEqually
        stackFila.alignment = .fill
        stackFila.spacing = 1
        stackFila.axis = .horizontal
        
        return stackFila
    }
    
}
