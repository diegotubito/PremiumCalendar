//
//  PCMensualViewModel.swift
//  PremiumCalendar
//
//  Created by David Diego Gomez on 6/1/19.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import UIKit

class PCMensualViewModel: NSObject, PCMensualViewModelContract {
  
     
    var model: PCMensualModel
    var _view : PCMensualViewContract!
    
    required init(withCustomView view: PCMensualViewContract) {
        _view = view
        
        let selectedItems : [Int] = []
        model = PCMensualModel(selectionMode: PCMensualSelectionMode.doubleSelection, selectedItems: selectedItems)
    
        model.construirNombreDias()
  
    }
    
    func getNameDay(index: Int) -> String {
        return model.nombreDiasConstruidos[index]
    }
    
    func getDayValues(fila: Int, columna: Int) -> PCMensualValores {
        
        
        let i = columna + (fila*7)
        let diaInicial = queDiaEmpiezaElMes(fecha: model.viewDate)
              
        let mesAnterior = Calendar.current.date(byAdding: .month, value: -1, to: model.viewDate)
        let mesSiguiente = Calendar.current.date(byAdding: .month, value: 1, to: model.viewDate)
        
        let diasMaximoMesAnteriorEnPantalla = mesAnterior?.endDay()
        let diasMaximoMesActualEnPantalla = model.viewDate!.endDay()
        let diasMaximoMesSiguienteEnPantalla = mesSiguiente?.endDay()
        
        var x : Int = i - diaInicial + 2 + model.firstDay.raw
        let valorEnCero = x - i
        var offset = 0
        
        if valorEnCero > 1 {
            offset = -7
        }
    
        x = x + offset
        
    
        
        if x > 0 && x <= diasMaximoMesActualEnPantalla {
            return PCMensualValores(fila: fila, columna: columna, antActSig: 0, dia: x)
            
        } else if x <= 0 {
            return PCMensualValores(fila: fila, columna: columna, antActSig: -1, dia: (x + diasMaximoMesAnteriorEnPantalla!))
        } else {
            return PCMensualValores(fila: fila, columna: columna, antActSig: 1, dia: (x - diasMaximoMesActualEnPantalla))
        }
    }
    
    func selectedView(_ tuple: (Int, Int)) {
        let index = tuple.1 + (tuple.0 * 7)
        
        if model.selectionMode == PCMensualSelectionMode.singleSelection {
            model.selectedItems.removeAll()
            model.selectedItems.append(index)
        } else if model.selectionMode == PCMensualSelectionMode.randomSelection {
            if let index = model.selectedItems.firstIndex(where: {$0 == index}) {
                model.selectedItems.remove(at: index)
            } else {
                model.selectedItems.append(index)
            }
        } else if model.selectionMode == PCMensualSelectionMode.doubleSelection {
            if model.selectedItems.count > 2 {
                model.selectedItems.removeAll()
                model.selectedItems.append(index)
            } else if model.selectedItems.count == 1 {
                model.selectedItems.append(index)
                selectInBetween()

             } else {
                model.selectedItems.append(index)
            }
            
        } else if model.selectionMode == PCMensualSelectionMode.doubleSelection {
            
        }
         _view.showSelectedItems()
        
     }
    
    func selectInBetween() {
        let indexA = model.selectedItems[0]
        let indexB = model.selectedItems[1]
        
        var menor = indexB
        var mayor = indexA
        if indexA < indexB {
            menor = indexA
            mayor = indexB
        }
        for x in 0...42 {
            if x >= menor && x <= mayor {
                model.selectedItems.append(x)
            }
        }
    }
    
    func avanzarMes() {
        model.viewDate.sumarMes(valor: 1)
        _view.updateDays()
    }
    
    func retrocederMes() {
        model.viewDate.sumarMes(valor: -1)
        _view.updateDays()
        
    }
    
    
}


extension Date {
    mutating func sumarMes(valor: Int) {
        let myCalendar = Calendar(identifier: .gregorian)
        self = myCalendar.date(byAdding: .month, value: valor, to: self)!

    }
    
    var dayName : String {
        let valor = Calendar.current.component(.weekday, from: self)
        return arrayNombreDias[valor]
    }
    
    func startDay() -> Int {
        let myCalendar = Calendar(identifier: .gregorian)
        return myCalendar.component(.weekday, from: self)
    }
    
    func endDay() -> Int {
        let myCalendar = Calendar(identifier: .gregorian)
        
        // Calculate start and end of the current year (or month with `.month`):
        let interval = myCalendar.dateInterval(of: .month, for: self)!
        
        // Compute difference in days:
        let days = myCalendar.dateComponents([.day], from: interval.start, to: interval.end).day!
        return days
    }
    
}
