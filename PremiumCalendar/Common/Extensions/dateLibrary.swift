//
//  dateLibrary.swift
//  coreGym21
//
//  Created by David Diego Gomez on 20/10/18.
//  Copyright © 2018 Gomez David Diego. All rights reserved.
//

import Foundation

/*
struct FormatosDeFechas {
    static let fecha = "dd-MM-yyyy"
    static let fechaConHora = "dd-MM-yyyy HH:mm:ss"
    static let fechaConHoraSinSeg = "dd-MM-yyyy HH:mm"
    
    
    static let hora12 = "HH:mm"
    static let hora24 = "HH:mm a"
    static let hora12seg = "HH:mm:ss a"
    static let hora24seg = "HH:mm:ss a"
}

*/

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
    
    var mes : Int {
        let calendar = Calendar.current
        let mes = calendar.component(.month, from: self)
        
        return mes
    }
    
    var año : Int {
        let calendar = Calendar.current
        let mes = calendar.component(.year, from: self)
        
        return mes
    }

    
}

extension String {
    func toDate(formato: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formato
        
        let dateNSDate = dateFormatter.date(from: self)
        
        return dateNSDate
    }
}

extension Date {
    func toString(formato: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formato
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}

extension Date {
    func desdeHace(numericDates: Bool) -> String {
        
        let str = timeAgoSinceDate(date: self as NSDate, numericDates: numericDates)
        return str
    }
}

extension Date {
    func mesesTranscurridos(fecha: Date) -> Int? {
        let calendar : NSCalendar = NSCalendar.current as NSCalendar
        let ageComponents = calendar.components(.month, from: self, to: fecha, options: [])
        let meses = ageComponents.month
        
        return meses
    }
    
    func diasTranscurridos(fecha: Date) -> Int? {
        let calendar : NSCalendar = NSCalendar.current as NSCalendar
        let ageComponents = calendar.components(.day, from: self, to: fecha, options: [])
        let dias = ageComponents.day
        
        return dias
    }
    
    func horasTranscurridas(fecha: Date) -> Int? {
        let calendar : NSCalendar = NSCalendar.current as NSCalendar
        let ageComponents = calendar.components(.hour, from: self, to: fecha, options: [])
        let horas = ageComponents.hour
        
        return horas
    }
    
    func segundosTranscurridos(fecha: Date) -> Int? {
        let calendar : NSCalendar = NSCalendar.current as NSCalendar
        let ageComponents = calendar.components(.second, from: self, to: fecha, options: [])
        let segundos = ageComponents.second
        
        return segundos
    }
}


func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
    let calendar = NSCalendar.current
    let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
    let now = NSDate()
    let earliest = now.earlierDate(date as Date)
    let latest = (earliest == now as Date) ? date : now
    let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
    
    if (components.year! >= 2) {
        return "hace \(components.year!) años"
    } else if (components.year! >= 1){
        if (numericDates){
            return "hace 1 año"
        } else {
            return "el año pasado"
        }
    } else if (components.month! >= 2) {
        return "hace \(components.month!) meses"
    } else if (components.month! >= 1){
        if (numericDates){
            return "hace 1 mes"
        } else {
            return "El último mes"
        }
    } else if (components.weekOfYear! >= 2) {
        return "hace \(components.weekOfYear!) semanas"
    } else if (components.weekOfYear! >= 1){
        if (numericDates){
            return "hace 1 semana"
        } else {
            return "Desde la semana pasada"
        }
    } else if (components.day! >= 2) {
        return "hace \(components.day!) días"
    } else if (components.day! >= 1){
        if (numericDates){
            return "hace 1 día"
        } else {
            return "Ayer"
        }
    } else if (components.hour! >= 2) {
        return "hace \(components.hour!) horas"
    } else if (components.hour! >= 1){
        if (numericDates){
            return "hace 1 hora"
        } else {
            return "1 hora atrás"
        }
    } else if (components.minute! >= 2) {
        return "hace \(components.minute!) minutos"
    } else if (components.minute! >= 1){
        if (numericDates){
            return "hace 1 minuto"
        } else {
            return "Un minuto atrás"
        }
    } else if (components.second! >= 3) {
        return "hace \(components.second!) segundos"
    } else {
        return "Justo ahora"
    }
    
}
