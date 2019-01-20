//
//  ViewController.swift
//  PremiumCalendar
//
//  Created by David Diego Gomez on 2/1/19.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var calendario : PCMensualCustomView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      //  Toast.show(message: "Premium Calendar", controller: self)
     
     
        calendario = PCMensualCustomView(frame: CGRect(x: 16, y: 35, width: view.frame.width-32, height: 250))
        calendario.colorLabelDia = UIColor.white
        calendario.layer.cornerRadius = 250/20
        calendario.layer.borderColor = UIColor.white.cgColor
        calendario.layer.borderWidth = 2
        view.addSubview(calendario)
 
        
     /*   let renderer1 = UIGraphicsImageRenderer(size: CGSize(width: 500, height: 500))
        let img1 = renderer1.image { ctx in
            ctx.cgContext.setStrokeColor(UIColor.white.cgColor)
            ctx.cgContext.setLineWidth(3)
            
            ctx.cgContext.move(to: CGPoint(x: 50, y: 450))
            ctx.cgContext.addLine(to: CGPoint(x: 250, y: 50))
            ctx.cgContext.addLine(to: CGPoint(x: 450, y: 450))
            ctx.cgContext.addLine(to: CGPoint(x: 50, y: 450))
            
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        let imageview = UIImageView()
        imageview.image = img1
        view.addSubview(imageview)
 */
    /*
        calendario.alpha = 0
        UIView.animate(withDuration: 0.75, delay: 0.0, options: .curveEaseIn, animations: {
            self.calendario.alpha = 1.0
        })
     */
     }


}

