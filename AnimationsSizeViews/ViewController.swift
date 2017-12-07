//
//  ViewController.swift
//  AnimationsSizeViews
//
//  Created by Vinicius Torres on 12/6/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var curvedView: UIView!
    
//    var backForOriginalSize = UIButton()
    
    let topInitialSize: CGFloat = 200.0
    var initialCurvedPosition = CGPoint()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                
        curvedView.backgroundColor = .clear
        curvedView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(expandAnimation)))
        self.configureCurvedView()
        
//        self.configureBackButton()
    }
    
    func configureCurvedView() {
        
        let path = UIBezierPath()
        
        path.move(to: CGPoint(x: 0, y: 0))
        
        let endPoint = CGPoint(x: self.curvedView.frame.width, y: 0)
        
        let cp1 = CGPoint(x: self.curvedView.frame.width/2, y: self.curvedView.frame.size.height * 2)
        
        path.addQuadCurve(to: endPoint, controlPoint: cp1)
        
        path.lineWidth = 0
        path.stroke()
        
        //fill curved area background
        
        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillColor = UIColor.orange.cgColor
        
        self.curvedView.layer.addSublayer(fillLayer)
    }
    
//    func configureBackButton() {
//
//        backForOriginalSize.frame = CGRect(origin: CGPoint(x: 10,y: self.view.frame.size.height - 60), size: CGSize(width: self.topView.frame.size.width - 20, height: 30))
//
//        backForOriginalSize.backgroundColor = .clear
//        backForOriginalSize.tintColor = .white
//        backForOriginalSize.setTitle("Voltar", for: .normal)
//        backForOriginalSize.layer.borderColor = UIColor.white.cgColor
//        backForOriginalSize.layer.borderWidth = 1
//        backForOriginalSize.addTarget(self, action: #selector(returnAnimation), for: .touchUpInside)
//
//    }
    
    @objc func handleTap() {
        
        self.expandAnimation()

    }
    
    @objc func expandAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
            self.topView.frame.size.height = self.view.frame.size.height
            self.initialCurvedPosition = self.curvedView.layer.position
            self.curvedView.layer.position.y = self.topView.frame.size.height + self.curvedView.frame.size.height/2 + 2
        }, completion: { (_) in
            self.topView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.returnAnimation)))
//            self.topView.addSubview(self.backForOriginalSize)
        })
    }
    
    
    @objc func returnAnimation() {
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
//            self.backForOriginalSize.removeFromSuperview()
            self.topView.frame.size.height = self.topInitialSize
            self.curvedView.layer.position =  self.initialCurvedPosition

        }, completion: nil)
    }


}


