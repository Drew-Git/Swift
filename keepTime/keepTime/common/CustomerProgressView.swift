//
//  PlainHorizontalProgressBar.swift
//  keepTime
//
//  Created by 김선종 on 2020/11/01.
//  Copyright © 2020 drewVvv. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CustomerProgressView: UIView {
    @IBInspectable var color: UIColor = .gray
    @IBInspectable var gradientColor: UIColor = .gray
    var progress: CGFloat = 0 {
        didSet { setNeedsDisplay()}
    }
    private let progressLayer = CALayer()
    let backgroundMask = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(progressLayer)
        setupLayers()
        createAnimation()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.addSublayer(progressLayer)
        setupLayers()
        createAnimation()
    }
    
    // gradientLayer
    private let gradientLayer = CAGradientLayer()
    
    private func setupLayers() {
        layer.addSublayer(gradientLayer)
//        gradientLayer.frame = layer.frame
        gradientLayer.mask = progressLayer
        gradientLayer.locations = [0.35, 0.5, 0.65]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
    }
    
    private func createAnimation() {
        let flowAnimation = CABasicAnimation(keyPath: "locations")
        flowAnimation.fromValue = [-0.3, -0.15, 0]
        flowAnimation.toValue = [1, 1.15, 1.3]
        
        flowAnimation.isRemovedOnCompletion = false
        flowAnimation.repeatCount = Float.infinity
        flowAnimation.duration = 1
        
        gradientLayer.add(flowAnimation, forKey: "flowAnimation")
    }
    
    override func draw(_ rect: CGRect) {
//        backgroundColor?.setFill()
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.25).cgPath
//        backgroundMask.fillColor = nil
//        backgroundMask.strokeColor = UIColor.black.cgColor
        layer.mask = backgroundMask
        
        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))
        progressLayer.frame = progressRect
        progressLayer.backgroundColor = UIColor.black.cgColor
        
        gradientLayer.frame = rect
        gradientLayer.colors = [color.cgColor, gradientColor.cgColor, color.cgColor]
        gradientLayer.endPoint = CGPoint(x: progress, y: 0.5)
        layer.addSublayer(progressLayer)
        progressLayer.backgroundColor = color.cgColor
    }
}
