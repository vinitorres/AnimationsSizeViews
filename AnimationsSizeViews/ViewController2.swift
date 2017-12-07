//
//  ViewController2.swift
//  AnimationsSizeViews
//
//  Created by Vinicius Torres on 12/6/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    @IBOutlet weak var cardAreaView: UIView!
    
    var currentCard = UIView()
    var panGesture = UIPanGestureRecognizer()
    var reactionImageReference = UIImageView()
    
    var titles: [String] = ["asasafee","gasddsdsdfgdfg","gdfgdfg","asdasd","absa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if titles.count > 0 {
            loadCardInfo()
        } else {
            setEmpty()
        }

    }
    
    func setEmpty() {
        print("Nenhuma informação encontrada")
        self.cardAreaView.alpha = 0
    }
    
    func loadCardInfo() {
        
        if titles.count > 0 {
            
            reactionImageReference.alpha = 0
            let view = CardView.init(frame: self.view.frame)
            view.frame.size = self.cardAreaView.frame.size
            view.frame.origin = self.cardAreaView.frame.origin
            view.titleCardLabel.text = titles[0]
            reactionImageReference = view.reactionImageView
            panGesture.addTarget(self, action: #selector(panCard))
            view.addGestureRecognizer(panGesture)
            currentCard = view
            self.view.addSubview(currentCard)
        
        } else {
            setEmpty()
        }
    }
    
    @objc func panCard() {
        
        guard let card = panGesture.view else { return }
        let point = panGesture.translation(in: view)
        card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
        
        let xFromCenter = card.center.x - view.center.x
        
        if xFromCenter > 0 {
            reactionImageReference.image = #imageLiteral(resourceName: "like")
            reactionImageReference.tintColor = UIColor.green
        } else {
            reactionImageReference.image = #imageLiteral(resourceName: "unlike")
            reactionImageReference.tintColor = UIColor.red
        }
        
        reactionImageReference.alpha = abs(xFromCenter)/view.center.x
        
        
        if panGesture.state == UIGestureRecognizerState.ended {
            
            if card.center.x < 75 {
                UIView.animate(withDuration: 0.4, animations: {
                    card.center = CGPoint(x: card.center.x - 200, y: card.center.y + 75)
                    card.alpha = 0
                    self.titles.remove(at: 0)
                },completion: { (_) in
                    self.currentCard.removeFromSuperview()
                    self.loadCardInfo()
                })
                
                return
            } else if card.center.x > (view.frame.width - 75) {
                UIView.animate(withDuration: 0.4, animations: {
                    card.center = CGPoint(x: card.center.x + 200, y: card.center.y + 75)
                    card.alpha = 0
                    self.titles.remove(at: 0)
                },completion: { (_) in
                    self.currentCard.removeFromSuperview()
                    self.loadCardInfo()
                })
                return
            }
            
            UIView.animate(withDuration: 0.2) {
                card.center = self.view.center
                self.reactionImageReference.alpha = 0
            }
            
        }
        
    }


}
