//
//  ViewController.swift
//  PremiumCalendar
//
//  Created by David Diego Gomez on 2/1/19.
//  Copyright © 2019 Gomez David Diego. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      //  Toast.show(message: "Premium Calendar", controller: self)
     
        view.backgroundColor = UIColor.darkGray
        
        let prueba = PCDiaCustomView(frame: CGRect(x: 50, y: 50, width: 200, height: 50))
        prueba.index = 33
        prueba.delegate = self
        view.addSubview(prueba)
        
     }


}

extension ViewController: PCDiaCustomViewDelegate {
    func didTouched(index: Int) {
        print(index)
    }
    
    
}

