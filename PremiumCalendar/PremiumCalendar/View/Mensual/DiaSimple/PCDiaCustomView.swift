//
//  PCDiaCustomView.swift
//  PremiumCalendar
//
//  Created by David Diego Gomez on 4/1/19.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import UIKit

extension Notification.Name {
    //notificacion antes de cerrar la aplicacion
    static let dayDidTouchNotification = Notification.Name("dayDidTouchNotification")
}

protocol PCDiaCustomViewDelegate {
    func didTouched(fila: Int, columna: Int)
}

class PCDiaCustomView: UIView {
    
    var fila : Int?
    var columna : Int?
    
    var delegate : PCDiaCustomViewDelegate?
    var index : Int = 0
    
    var radio: CGFloat = 0 {
        didSet {
            layer.cornerRadius = radio
        }
    }
    
    var bordeColor : UIColor = UIColor.black {
        didSet {
            layer.borderColor = bordeColor.cgColor
        }
    }
    
    var bordeAncho : CGFloat = 0 {
        didSet {
            layer.borderWidth = bordeAncho
        }
    }

    override init(frame: CGRect) {
        super .init(frame: frame)
        inicializar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super .init(coder: aDecoder)
        inicializar()
    }
    
    
    func inicializar() {
        let contentFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        frame = contentFrame
        
        isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tapGesture)
        
        dibujar()
    }
    
    @objc func viewTapped() {
        let valor = (fila, columna)
        NotificationCenter.default.post(name: .dayDidTouchNotification, object: valor)
       self.delegate?.didTouched(fila: fila!, columna: columna!)
    }
    
    func dibujar() {
        backgroundColor = UIColor.red
    }
    

}
