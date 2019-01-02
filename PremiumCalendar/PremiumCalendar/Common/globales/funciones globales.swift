//
//  globales.swift
//  calendario2
//
//  Created by David Diego Gomez on 13/1/18.
//  Copyright © 2018 David Diego Gomez. All rights reserved.
//

import UIKit

func queDiaEmpiezaElMes(fecha: Date) -> Int {
    
    let fechaSeleccionada = "01-" + String(mesDeLaFecha(fecha: fecha)) + "-" + String(añoDeLaFecha(fecha: fecha))
    let formatter  = DateFormatter()
    formatter.dateFormat = "dd-MM-yyyy"
    
    var diaInicial = Int()
    if let todayDate = formatter.date(from: fechaSeleccionada) {
        let myCalendar = Calendar(identifier: .gregorian)
        diaInicial = myCalendar.component(.weekday, from: todayDate)
    }
    
    
    return diaInicial
}


func cuantosDiasTieneElMes(fecha: Date) -> Int{
    let myCalendar = Calendar(identifier: .gregorian)
    
    // Calculate start and end of the current year (or month with `.month`):
    let interval = myCalendar.dateInterval(of: .month, for: fecha)!
    
    // Compute difference in days:
    let days = myCalendar.dateComponents([.day], from: interval.start, to: interval.end).day!
    return days
}

func diasTranscurridos(fechaA: Date, fechaB: Date) -> Int{
    let calendar : NSCalendar = NSCalendar.current as NSCalendar
    
    let ageComponents = calendar.components(.day, from: fechaA, to: fechaB, options: [])
    
    let diasTranscurridos = ageComponents.day
    
    if diasTranscurridos == nil {
        return 0
    }
    return diasTranscurridos!
    
}

func desvanecerLabel(myLabel: UILabel, duracion: CGFloat) {
    myLabel.alpha = 1
    // myLabel.isEnabled = false
    myLabel.isHidden = false
    UIView.animate(withDuration: 3, animations: { () -> Void in
        myLabel.alpha = 0
        //   myLabel.isEnabled = true
    })
}

func convertirFechaAlphanumerica(fecha: String) -> String {
    let fechaNSDate = stringDate(fecha: fecha, formato: FECHA)
    
    let calendar = Calendar.current
    let diaDeLaSemana = calendar.component(.weekday, from: fechaNSDate as Date)
    let dia = calendar.component(.day, from: fechaNSDate as Date)
    let mes = calendar.component(.month, from: fechaNSDate as Date)
    let año = calendar.component(.year, from: fechaNSDate as Date)
    
    let nombreDia = DIAS[diaDeLaSemana]
    let nombreMes = MESES[mes]
    
    var fechaCreada = nombreDia! + " "
    
    fechaCreada += String(dia) + " "
    fechaCreada += nombreMes! + " " + String(año)
    
    return fechaCreada
    
    
    
}

extension UIImage {
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

func validarFecha(fecha: String) -> Bool {
    //me aseguro que el año contenga cuatro caracteres
    let array = fecha.components(separatedBy: ["-", "/"])
    
    if array.count == 3 {
        if array[2].count != 4 {
            return false
        }
    }
    
    // valido a traves de nsdate el valor de la fecha
    let s = stringDate(fecha: fecha, formato: FORMATO_NIL)
    let strDate = DateString(fecha: s, formato: FORMATO_NIL)
    if  strDate == FECHA_NIL {
        return false
    }
    else {
        return true
    }
    
}
/*
 func crearChildID() -> String {
 let ref = Database.database().reference()
 let referencia = ref.childByAutoId()
 
 return referencia.key
 }
 */
func stringDate(fecha: String, formato: String) -> Date {
    
    let dateString = fecha
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = formato
    
    let dateNSDate = dateFormatter.date(from:dateString)
    
    if dateNSDate == nil {
        let devolverDefault = dateFormatter.date(from:"01-01-1800")
        return devolverDefault!
    }
    return dateNSDate!
}

func DateString(fecha: Date, formato: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = formato
    let dateString = dateFormatter.string(from:fecha)
    return dateString
}

extension UIImageView {
    
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}

extension UIImageView {
    
    func setRounded(numero: CGFloat) {
        self.layer.cornerRadius = (self.frame.width / numero) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}

func diaDeLaFecha(fecha: Date) -> Int {
    
    let calendar = Calendar.current
    let numeroDeDia = calendar.component(.day, from: fecha)
    
    return numeroDeDia
}

func diaDeLaSemana(fecha: Date) -> String {
    let calendar = Calendar.current
    let diaDeLaSemana = calendar.component(.weekday, from: fecha)
    
    return DIAS[diaDeLaSemana]!
}

func añoDeLaFecha(fecha: Date) -> Int {
    let calendar = Calendar.current
    let año = calendar.component(.year, from: fecha)
    
    return año
}

func mesDeLaFecha(fecha: Date) -> Int {
    let calendar = Calendar.current
    let mes = calendar.component(.month, from: fecha)
    
    return mes
}

func numeroDecimalConSignoMoneda(numero: Double) -> String {
    let numberFormatter = NumberFormatter()
    numberFormatter.locale = NSLocale.current
    
    numberFormatter.numberStyle = NumberFormatter.Style.currency
    let formatoFinal = numberFormatter.string(from: NSNumber(value:numero))!
    
    return String(formatoFinal)
    
}

func animarBoton(sender: UIButton, duracion: Float) {
    sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
    
    UIView.animate(withDuration: TimeInterval(duracion),
                   delay: 0,
                   usingSpringWithDamping: CGFloat(0.20),
                   initialSpringVelocity: CGFloat(6.0),
                   options: UIView.AnimationOptions.allowUserInteraction,
                   animations: {
                    sender.transform = CGAffineTransform.identity
    },
                   completion: { Void in()  }
    )
}


extension String {
    var localized: String {
        //🖕Fuck the translators team, they don’t deserve comments
        return NSLocalizedString(self, comment: "")
    }
}


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}


extension UserDefaults {
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
}

extension Calendar {
    
    func dayOfWeek(_ date: Date) -> Int {
        var dayOfWeek = self.component(.weekday, from: date) + 1 - self.firstWeekday
        
        if dayOfWeek <= 0 {
            dayOfWeek += 7
        }
        
        return dayOfWeek
    }
    
    func startOfWeek(_ date: Date) -> Date {
        return self.date(byAdding: DateComponents(day: -self.dayOfWeek(date) + 1), to: date)!
    }
    
    func endOfWeek(_ date: Date) -> Date {
        return self.date(byAdding: DateComponents(day: 6), to: self.startOfWeek(date))!
    }
    
    func startOfMonth(_ date: Date) -> Date {
        return self.date(from: self.dateComponents([.year, .month], from: date))!
    }
    
    func endOfMonth(_ date: Date) -> Date {
        return self.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth(date))!
    }
    
    func startOfQuarter(_ date: Date) -> Date {
        let quarter = (self.component(.month, from: date) - 1) / 3 + 1
        return self.date(from: DateComponents(year: self.component(.year, from: date), month: (quarter - 1) * 3 + 1))!
    }
    
    func endOfQuarter(_ date: Date) -> Date {
        return self.date(byAdding: DateComponents(month: 3, day: -1), to: self.startOfQuarter(date))!
    }
    
    func startOfYear(_ date: Date) -> Date {
        return self.date(from: self.dateComponents([.year], from: date))!
    }
    
    func endOfYear(_ date: Date) -> Date {
        return self.date(from: DateComponents(year: self.component(.year, from: date), month: 12, day: 31))!
    }
}

func calcularEdad( Nacimiento: Date) -> Int{
    let hoy = Date()
    
    let calendar : NSCalendar = NSCalendar.current as NSCalendar
    let ageComponents = calendar.components(.year, from: Nacimiento, to: hoy, options: [])
    let age = ageComponents.year!
    
    return age
}


extension String {
    
    static func random(length: Int = 20) -> String {
        let base = "-_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}


func mesesTranscurridos(fechaA: Date, fechaB: Date) -> Int{
    let calendar : NSCalendar = NSCalendar.current as NSCalendar
    
    let ageComponents = calendar.components(.month, from: fechaA, to: fechaB, options: [])
    
    let mesesTranscurridos = ageComponents.month
    
    if mesesTranscurridos == nil {
        return 0
    }
    return mesesTranscurridos!
    
}

func fechaConNombreDeDia(fecha: Date) -> String {
    let _fecha = DateString(fecha: fecha, formato: FECHA)
    let hoy = DateString(fecha: Date(), formato: FECHA)
    
    var stringFecha = String()
    
    if _fecha == hoy {
        stringFecha = "Hoy ".localized + DateString(fecha: fecha, formato: HORA_SIN_SEGUNDOS)
    } else {
        let diaNombre = diaDeLaSemana(fecha: fecha)
        stringFecha = diaNombre + " " + DateString(fecha: fecha, formato: FECHA_CON_HORA_SIN_SEGUNDOS)
    }
    return stringFecha
}

