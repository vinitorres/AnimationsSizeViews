//
//  CardView.swift
//  AnimationsSizeViews
//
//  Created by Vinicius Torres on 12/7/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var titleCardLabel: UILabel!
    @IBOutlet weak var reactionImageView: UIImageView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
        self.addSubview(self.view)
        self.view.frame = frame
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        Bundle.main.loadNibNamed("CardView", owner: self, options: nil)
        self.addSubview(self.view)
        self.view.frame = frame
    }

}
