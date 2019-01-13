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
    
    func updateDays() {
        for i in 0...41 {
            let atributos = getAttributes(i: i)
            listaViews[i].labelCentral.text = String(atributos.dia)
            listaViews[i].colorLabelCentral = getLabelColor(atributos)
            listaViews[i].fuenteLabelCentral = getLabelFont(atributos)
            
            
        }
    }
    
    func getAttributes(i: Int) -> PCMensualValores {

        let diaInicial = queDiaEmpiezaElMes(fecha: viewModel.model.viewDate)
        
        let mesAnterior = Calendar.current.date(byAdding: .month, value: -1, to: viewModel.model.viewDate)
        let mesSiguiente = Calendar.current.date(byAdding: .month, value: 1, to: viewModel.model.viewDate)
        
        let diasMaximoMesAnteriorEnPantalla = mesAnterior?.endDay()
        let diasMaximoMesActualEnPantalla = viewModel.model.viewDate!.endDay()
        let diasMaximoMesSiguienteEnPantalla = mesSiguiente?.endDay()
        
        var x : Int = i - diaInicial + 2 + viewModel.model.firstDay.raw
        let valorEnCero = x - i
        var offset = 0
        
        if valorEnCero > 1 {
            offset = -7
        }
        
        x = x + offset
        
        
        
        if x > 0 && x <= diasMaximoMesActualEnPantalla {
            return PCMensualValores(fila: 0, columna: 0, antActSig: 0, dia: x)
            
        } else if x <= 0 {
            return PCMensualValores(fila: 0, columna: 0, antActSig: -1, dia: (x + diasMaximoMesAnteriorEnPantalla!))
        } else {
            return PCMensualValores(fila: 0, columna: 0, antActSig: 1, dia: (x - diasMaximoMesActualEnPantalla))
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
