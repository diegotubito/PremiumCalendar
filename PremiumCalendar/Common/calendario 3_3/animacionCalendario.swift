//
//  accionesCalendario.swift
//  calendario3_1
//
//  Created by David Diego Gomez on 20/1/18.
//  Copyright © 2018 David Diego Gomez. All rights reserved.
//

import Foundation
import UIKit

extension Calendario: CAAnimationDelegate {
    
    /*
    func fadeOut(layer: CALayer) {
        let fadeOutAnimation = CABasicAnimation()
        fadeOutAnimation.keyPath = "opacity"
        fadeOutAnimation.fromValue = 1
        fadeOutAnimation.toValue = 0
        fadeOutAnimation.duration = 0.25
        
        fadeOutAnimation.delegate = self
        
        layer.add(fadeOutAnimation,
                  forKey: "fade")
    }
    
    
    
    func fadeIn(layer: CALayer) {
        let ani = CABasicAnimation(keyPath: "opacity")
        ani.setValue(animacion.efectoHoy.nombre, forKey: "name")
        ani.delegate = self
        ani.fromValue = 0
        ani.toValue = 1
        ani.duration = 0.33
        
        layer.add(ani, forKey: nil)
    }
    */
    func animarHoy(layer: CALayer) {
        if animacion.efectoHoy.disabled {
            return
        }
        animacion.efectoHoy.disabled = true
        
        let wobble = `CAKeyframeAnimation`(keyPath: "transform.rotation")
        wobble.beginTime = CACurrentMediaTime() + 0.22
        wobble.duration = 0.25
        wobble.repeatCount = 2
        wobble.values = [0.0, -.pi/10.0, 0.0, .pi/10.0, 0.0]
        wobble.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        
        layer.add(wobble, forKey: nil)
    }
     
    
    func animarSeleccion(layer: CALayer) {
        let ani = CASpringAnimation(keyPath: "transform.scale")
        ani.setValue(animacion.efectoHoy.nombre, forKey: "name")
        ani.delegate = self
        ani.fromValue = 0.2
        ani.toValue = 1
        ani.initialVelocity = 10
        ani.damping = 10
        ani.duration = ani.settlingDuration
        ani.isRemovedOnCompletion = true
        
        layer.add(ani, forKey: nil)
    }
    
    func animarCerrarCalendario() {
        let calculoPosicionX = -center.x/2
        let calculoPosicionY = -center.y/2
        
        let moveToCorner = CAKeyframeAnimation(keyPath: "position")
        moveToCorner.duration = 0.66
        moveToCorner.values = [
            CGPoint(x: layer.position.x, y: layer.position.y),
            CGPoint(x: calculoPosicionX, y: calculoPosicionY)
            ].map { NSValue(cgPoint: $0) }
        moveToCorner.keyTimes = [0.0, 0.66]
        moveToCorner.repeatCount = 1
        moveToCorner.delegate = self
        moveToCorner.setValue(animacion.cerrarCalendario.nombre, forKey: "name")
        
        layer.add(moveToCorner, forKey: nil)
        layer.position = CGPoint(x: calculoPosicionX, y: calculoPosicionY)
        
        
        let escalar = CASpringAnimation(keyPath: "transform.scale")
        escalar.damping = 100
        escalar.initialVelocity = 10
        escalar.duration = escalar.settlingDuration
        escalar.fromValue = 1.0
        escalar.toValue = 0.0
        
        layer.add(escalar, forKey: nil)
        transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    }
    
    
    func animarPalabraHoy() {
        if animacion.animacionPalabraHoy.disabled {
            return
        }
        animacion.animacionPalabraHoy.disabled = true
        
        let ani = CASpringAnimation(keyPath: "transform.scale")
        ani.fromValue = 0.0
        ani.toValue = 4
        ani.initialVelocity = 0
        ani.damping = 100
        ani.duration = ani.settlingDuration
        ani.isRemovedOnCompletion = false
        ani.delegate = self
        ani.setValue(animacion.animacionPalabraHoy.nombre, forKey: "name")
        ani.beginTime = CACurrentMediaTime() + 0.5
        
        hoyLabel.layer.add(ani, forKey: nil)
        hoyLabel.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        
        
        let fadeOutAnimation = CABasicAnimation()
        fadeOutAnimation.beginTime = CACurrentMediaTime() + 0.5
        fadeOutAnimation.keyPath = "opacity"
        fadeOutAnimation.fromValue = 1
        fadeOutAnimation.toValue = 0
        fadeOutAnimation.duration = ani.duration
        fadeOutAnimation.isRemovedOnCompletion = false
        
        fadeOutAnimation.delegate = self
        
        hoyLabel.layer.add(fadeOutAnimation,
                           forKey: nil)
        
        
    }
    
    
    func reboteBoton(layer: CALayer) {
        
        let ani = CASpringAnimation(keyPath: "transform.scale")
        ani.setValue(animacion.efectoSeleccionDeMes.nombre, forKey: "name")
        ani.delegate = self
        ani.fromValue = 0.2
        ani.toValue = 1
        ani.initialVelocity = 10
        ani.damping = 10
        ani.duration = ani.settlingDuration
        ani.isRemovedOnCompletion = true
        
        layer.add(ani, forKey: nil)
        
        
        
    }
    
    
    func animarSwipeIzquierdo(label: UILabel) {
        let mover = CASpringAnimation(keyPath: "position.x")
        mover.fromValue = label.frame.width
        mover.toValue = label.center.x
        mover.damping = 100
        mover.initialVelocity = 10
        mover.duration = mover.settlingDuration
        mover.delegate = self
        
        
        label.layer.add(mover, forKey: nil)
    }
    
    func animarSwipeDerecho(label: UILabel) {
        let mover = CASpringAnimation(keyPath: "position.x")
        mover.fromValue = label.frame.minX
        mover.toValue = label.center.x
        mover.damping = 100
        mover.initialVelocity = 6
        mover.duration = mover.settlingDuration
        mover.delegate = self
        
        
        label.layer.add(mover, forKey: nil)
    }
    
    func temblar(layer: CALayer) {
        let wobble = `CAKeyframeAnimation`(keyPath: "transform.rotation")
        wobble.beginTime = CACurrentMediaTime()
        wobble.duration = 0.25
        wobble.repeatCount = 1
        wobble.values = [0.0, -.pi/10.0, 0.0, .pi/10.0, 0.0]
        wobble.keyTimes = [0.0, 0.25, 0.5, 0.75, 1.0]
        
        layer.add(wobble, forKey: nil)
    }
    
    
    
    func maximizar(animated: Bool) {
        isMinimized = false
        let escalar = CASpringAnimation(keyPath: "transform.scale")
        escalar.damping = 10
        escalar.initialVelocity = -10
        escalar.duration = escalar.settlingDuration
        escalar.fromValue = relacionCompresion
        escalar.toValue = 1
        escalar.delegate = self
        
        
        let calculoPosicionX = posicionMaximizadaX
        let calculoPosicionY = posicionMaximizadaY
        
        let moveToCorner = CAKeyframeAnimation(keyPath: "position")
        moveToCorner.duration = 0.66
        moveToCorner.values = [
            CGPoint(x: layer.position.x, y: layer.position.y),
            CGPoint(x: calculoPosicionX!, y: calculoPosicionY!)
            ].map { NSValue(cgPoint: $0) }
        moveToCorner.keyTimes = [0.0, 0.66]
        moveToCorner.repeatCount = 1
        moveToCorner.delegate = self
        
        if animated {
            layer.add(escalar, forKey: nil)
            layer.add(moveToCorner, forKey: nil)
        }
        transform = CGAffineTransform(scaleX: 1, y: 1)
        layer.position = CGPoint(x: calculoPosicionX!, y: calculoPosicionY!)
        
    }
    func minimizar(animated: Bool) {
        isMinimized = true
        let escalar = CASpringAnimation(keyPath: "transform.scale")
        escalar.damping = 10
        escalar.initialVelocity = -10
        escalar.duration = escalar.settlingDuration
        escalar.fromValue = 1.0
        escalar.toValue = relacionCompresion
        escalar.delegate = self
        
        
        let calculoPosicionX = posicionMinimizadaX
        let calculoPosicionY = posicionMinimizadaY
        
        let moveToCorner = CAKeyframeAnimation(keyPath: "position")
        moveToCorner.duration = 0.66
        moveToCorner.values = [
            CGPoint(x: layer.position.x, y: layer.position.y),
            CGPoint(x: calculoPosicionX!, y: calculoPosicionY!)
            ].map { NSValue(cgPoint: $0) }
        moveToCorner.keyTimes = [0.0, 0.66]
        moveToCorner.repeatCount = 1
        moveToCorner.delegate = self
        
        
        if animated {
            layer.add(escalar, forKey: nil)
            layer.add(moveToCorner, forKey: nil)
        }
        
        transform = CGAffineTransform(scaleX: relacionCompresion, y: relacionCompresion)
        layer.position = CGPoint(x: calculoPosicionX!, y: calculoPosicionY!)
   
        
    }
    
    func transicionCalendarios(layer: CALayer) {
        let escala = CABasicAnimation(keyPath: "transform.scale.x")
        escala.fromValue = 1
        escala.toValue = 0
        escala.duration = 0.3
        
        layer.add(escala, forKey: nil)
    }
    func transicionCalendarios2(layer: CALayer) {
        let escala = CABasicAnimation(keyPath: "opacity")
        escala.fromValue = 0
        escala.toValue = 1
        escala.duration = 0.3
        
        layer.add(escala, forKey: nil)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let layer = anim.value(forKey: "layer") as? CALayer
        
        layer?.removeFromSuperlayer()
        
   /*     guard let name = anim.value(forKey: "name") as? String else {
            return
        }
       
     */
      
        
    }
 
}
