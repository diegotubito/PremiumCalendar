//
//  PCGrillaMensualCustomView.swift
//  PremiumCalendar
//
//  Created by David Diego Gomez on 6/1/19.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import UIKit

@IBDesignable
class PCMensualCustomView: UIView, PCMensualViewContract {
       

    var listaViews = [PCDiaCustomView]()
    
    var viewModel : PCMensualViewModelContract!
    
    func updateView() {
        dibujarGrilla()
    }
    
    @IBInspectable
    var colorLabelDia: UIColor = UIColor.white {
        didSet {
            dibujarGrilla()
        }
    }
    
    @IBInspectable
    var fuenteLabelDia: String = "Arial" {
        didSet {
            dibujarGrilla()
        }
    }
    @IBInspectable
    var tamañoFuente: CGFloat = 10.0 {
        didSet {
            dibujarGrilla()
        }
    }
    
    @IBInspectable
    var fondoPlantilla: UIColor = UIColor.blue {
        didSet {
            dibujarGrilla()
        }
    }
    
    @IBInspectable
    var fondoDia: UIColor = UIColor.blue {
        didSet {
            dibujarGrilla()
        }
    }
    
   
    @IBInspectable
    var radio: CGFloat = 0 {
        didSet {
            dibujarGrilla()
        }
    }
    
    @IBInspectable
    var bordeColor : UIColor = UIColor.black {
        didSet {
            dibujarGrilla()
        }
    }
    
    @IBInspectable
    var bordeAncho : CGFloat = 0 {
        didSet {
            dibujarGrilla()
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
     
         self.viewModel = PCMensualViewModel(withCustomView: self)
         self.dibujarGrilla()
    }
    
   
    func deselectAll() {
        for view in listaViews {
            view.fondoSeleccion.backgroundColor = UIColor.clear
        }
    }
    
    func showSelectedItems() {
        deselectAll()
        
        for index in viewModel.model.selectedItems {
            let view = listaViews[index]
            view.fondoSeleccion.backgroundColor = UIColor.red
            
            animarSegunModo(view: view)
                
        }
        
    }
    
    func animarSegunModo(view: PCDiaCustomView) {
      
        view.buttonAnimation()
        if viewModel.model.selectionMode == PCMensualSelectionMode.doubleSelection && viewModel.model.selectedItems.count >= 2 {
            animarViewModeDoubleSelection(view: view)
        }
        
    }
    
    func animarViewModeDoubleSelection(view: PCDiaCustomView) {
        
        view.fondoSeleccion.transform = CGAffineTransform(scaleX: 0, y: 0)
        
        UIButton.animate(withDuration: 0.2, delay: 0.02,
                         animations: {
                            view.fondoSeleccion.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })

    }
    
    func getLabelColor(_ valor: PCMensualValores) -> UIColor {
        if viewModel.model.columnasOscurecidas.contains(valor.columna) {
            return UIColor.lightGray
        } else {
            if valor.antActSig == 0 {
                //mes actual
                return UIColor.white
            } else {
                return UIColor.lightGray
            }
        }
    }
    
    func getLabelFont(_ valor: PCMensualValores) -> UIFont {
        if valor.antActSig == -1 {
            //mes anterior
            return UIFont.systemFont(ofSize: frame.height/20 * 0.8)
        } else if valor.antActSig == 0 {
            //mes actual
            return UIFont.systemFont(ofSize: frame.height/20)
        } else {
            //mes siguiente
            return UIFont.systemFont(ofSize: frame.height/20 * 0.8)
        }
    }
    
}


extension PCMensualCustomView: PCDiaCustomViewDelegate {
    func didTouched(fila: Int, columna: Int) {
        
        let valores = viewModel.getDayValues(fila: fila, columna: columna)
        
        viewModel.selectedView((fila, columna))
        
        
        print(valores.dia)
    }
  
}


extension PCMensualCustomView {
   /* override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            // do something with your currentPoint
      
         
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            // do something with your currentPoint
        
            print(currentPoint)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let currentPoint = touch.location(in: self)
            // do something with your currentPoint
           // print(currentPoint)
        }
    }*/
}
