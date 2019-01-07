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
     
     
        calendario = PCMensualCustomView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        calendario.colorLabelDia = UIColor.white
        view.addSubview(calendario)
 
 
    /*
        calendario.alpha = 0
        UIView.animate(withDuration: 0.75, delay: 0.0, options: .curveEaseIn, animations: {
            self.calendario.alpha = 1.0
        })
     */
     }


}

