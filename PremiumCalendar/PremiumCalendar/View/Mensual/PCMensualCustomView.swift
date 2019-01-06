//
//  PCGrillaMensualCustomView.swift
//  PremiumCalendar
//
//  Created by David Diego Gomez on 6/1/19.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import UIKit

@IBDesignable
class PCMensualCustomView: UIView {
    @IBInspectable
    var radio: CGFloat = 0 {
        didSet {
            inicializar()
        }
    }
    
    @IBInspectable
    var bordeColor : UIColor = UIColor.black {
        didSet {
            inicializar()
        }
    }
    
    @IBInspectable
    var bordeAncho : CGFloat = 0 {
        didSet {
            inicializar()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        inicializar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        inicializar()
    }
    
    func inicializar() {
        for i in subviews {
            i.removeFromSuperview()
        }
        dibujarGrilla()
    }
    
    func dibujarGrilla() {
        
 
        let grilla = crearColumnas()
        
        addSubview(grilla)
        
        grilla.translatesAutoresizingMaskIntoConstraints = false
        
        let a1 = NSLayoutConstraint(item: grilla, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
        let a2 = NSLayoutConstraint(item: grilla, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        let a3 = NSLayoutConstraint(item: grilla, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        let a4 = NSLayoutConstraint(item: grilla, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
        self.addConstraints([a1, a2, a3, a4])
        
        
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
           nuevaView.columna = index
            nuevaView.fila = fila
            nuevaView.bordeAncho = bordeAncho
            nuevaView.bordeColor = bordeColor
            nuevaView.radio = radio
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
