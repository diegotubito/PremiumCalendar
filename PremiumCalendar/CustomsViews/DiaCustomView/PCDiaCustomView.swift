//
//  PCDiaCustomView.swift
//  PremiumCalendar
//
//  Created by David Diego Gomez on 4/1/19.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import UIKit

protocol PCDiaCustomViewDelegate {
    func didTouched(index: Int)
}

class PCDiaCustomView: UIView {
    var delegate : PCDiaCustomViewDelegate?
    var index : Int = 0

    @IBOutlet var container: UIView!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        inicializar()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        inicializar()
    }
    
    func inicializar() {
        Bundle.main.loadNibNamed("PCDiaCustomView", owner: self, options: nil)
        
        let contentFrame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        container.frame = contentFrame
        addSubview(container)
        
        isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        addGestureRecognizer(tapGesture)
        dibujar()
    }
    
    @objc func viewTapped() {
        
        self.delegate?.didTouched(index: index)
    }
    
    func dibujar() {
        container.backgroundColor = UIColor.lightGray
    }
    

}
