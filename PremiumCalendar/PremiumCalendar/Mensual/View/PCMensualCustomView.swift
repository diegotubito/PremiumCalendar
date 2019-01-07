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
    
    func dibujarGrilla() {
        for i in self.subviews {
            i.removeFromSuperview()
        }
        listaViews.removeAll()
        
        backgroundColor = fondoPlantilla
 
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
            nuevaView.colorLabelCentral = colorLabelDia
            nuevaView.fuenteLabelCentral = UIFont(name: fuenteLabelDia, size: tamañoFuente)!
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
            if viewModel.model.selectionMode == PCMensualSelectionMode.doubleSelection && viewModel.model.selectedItems.count > 2 {
                view.zoomInWithEasing(duration: 1/(Double(index+1)), easingOffset:0.05)
            }
        }
        
    }
}


extension PCMensualCustomView: PCDiaCustomViewDelegate {
    func didTouched(fila: Int, columna: Int) {
        viewModel.selectedView((fila, columna))
    }
  
}