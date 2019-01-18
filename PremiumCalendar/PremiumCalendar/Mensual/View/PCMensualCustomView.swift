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
       
    var factorDimension : CGFloat = 1.0
    var tamañoHeader : CGFloat = 0
    var tamañoFontDiaDeLaSemana : CGFloat = 0
    
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
        let screenSize = UIScreen.main.bounds
        self.factorDimension = (frame.width + frame.height) / (screenSize.width + screenSize.height)
    
        self.viewModel = PCMensualViewModel(withCustomView: self)
        self.dibujarGrilla()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeftHandle))
        swipeLeft.direction = .left
        addGestureRecognizer(swipeLeft)
 
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeRightHandle))
        swipeRight.direction = .right
        addGestureRecognizer(swipeRight)
    }
    
    @objc func swipeLeftHandle() {
        viewModel.avanzarMes()
    }
    @objc func swipeRightHandle() {
        viewModel.retrocederMes()
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
    
   
    
    func updateDays() {
        
        for fila in 0...5 {
            for columna in 0...6 {
                let atributos = getDayAttibutes(fecha: viewModel.model.viewDate, fila: fila, columna: columna)
                let i = columna + (fila * 7)
                listaViews[i].labelCentral.text = String(atributos.numberDay)
                listaViews[i].colorLabelCentral = atributos.labelCentralColor
                listaViews[i].fuenteLabelCentral = atributos.labelCentralFont
            }
        }
       
    }
    
    func getDayAttibutes(fecha: Date, fila: Int, columna: Int) -> PCMensualDayAttribute {
        let i = columna + (fila*7)
        let diaInicial = queDiaEmpiezaElMes(fecha: fecha)
        
        let mesAnterior = Calendar.current.date(byAdding: .month, value: -1, to: fecha)
        
        let diasMaximoMesAnteriorEnPantalla = mesAnterior?.endDay()
        let diasMaximoMesActualEnPantalla = fecha.endDay()
        
        var x : Int = i - diaInicial + 2 + viewModel.model.firstDay.raw
        let valorEnCero = x - i
        var offset = 0
        
        if valorEnCero > 1 {
            offset = -7
        }
        
        x = x + offset
        
        
        let atributos = PCMensualDayAttribute()
        atributos.fila = fila
        atributos.columna = columna
        
        if x > 0 && x <= diasMaximoMesActualEnPantalla {
            atributos.antActSig = 0
            atributos.labelCentralFont = UIFont.systemFont(ofSize: frame.height/20)
            
            
        } else if x <= 0 {
            atributos.antActSig = 1
            x = x + diasMaximoMesAnteriorEnPantalla!
            atributos.labelCentralFont = UIFont.systemFont(ofSize: frame.height/20 * 0.3)
            
        } else {
            atributos.antActSig = -1
            x = x - diasMaximoMesActualEnPantalla
            atributos.labelCentralFont = UIFont.systemFont(ofSize: frame.height/20 * 0.3)
            
        }
        
        
        atributos.labelCentralColor = getLabelColor(atributos)
        atributos.numberDay = x
        
        
        return atributos
    }
    
    func getLabelColor(_ valor: PCMensualDayAttribute) -> UIColor {
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
    
    
}


extension PCMensualCustomView: PCDiaCustomViewDelegate {
    func didTouched(fila: Int, columna: Int) {
        
        viewModel.selectedView((fila, columna))
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
