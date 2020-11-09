//
//  TagCustom.swift
//  keepTime
//
//  Created by 김선종 on 2020/11/07.
//  Copyright © 2020 drewVvv. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTagView: UIView {

//    @IBInspectable var color : CGColor = .init(red: 100, green: 0, blue: 0, alpha: 0)
    @IBInspectable var color: UIColor = .gray {
        didSet {setNeedsDisplay()}
    }
    private let tagLayer = CALayer()
    private let backgroundMask = CAShapeLayer()
    var tagColor: UIColor = .gray {
        didSet { setNeedsDisplay()}

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
//        layer.addSublayer(tagLayer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
//        layer.addSublayer(tagLayer)
    }
    
    private func setupLayers() {
        layer.addSublayer(tagLayer)
    }
    
    
    override func draw(_ rect: CGRect) {
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height / 2).cgPath
        
        layer.mask = backgroundMask
        
        tagLayer.backgroundColor = tagColor.cgColor
        
//        let newView = UIView(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
//        newView.backgroundColor = color
//        newView.layer.masksToBounds = true
//        newView.layer.cornerRadius = 1/2
        
        
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
