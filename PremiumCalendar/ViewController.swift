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
     
     
        NotificationCenter.default.addObserver(self, selector: #selector(dayDidTouchedNotificationHandle(_:)), name: .dayDidTouchNotification, object: nil)
        calendario = PCMensualCustomView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        view.addSubview(calendario)
        
        calendario.alpha = 0
        UIView.animate(withDuration: 0.75, delay: 0.0, options: .curveEaseIn, animations: {
            self.calendario.alpha = 1.0
        })
        
     }


}

extension ViewController {
    
    @objc func dayDidTouchedNotificationHandle(_ sender: Notification) {
  
        let coordenadas = sender.object as? (Int, Int)
        print(coordenadas)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.calendario.alpha = 0.0
        }, completion: {_ in
            self.calendario.removeFromSuperview()
        })
        
    }
    
    
}

