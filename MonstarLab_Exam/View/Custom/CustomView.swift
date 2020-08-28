//
//  CustomView.swift
//  MonstarLab_Exam
//
//  Created by Aaron Musa on 8/28/20.
//  Copyright © 2020 Aaron Musa. All rights reserved.
//

import UIKit

@IBDesignable
class CustomView: UIView {
    
    // Radius
    @IBInspectable
    var topCorners: Bool = false
    @IBInspectable
    var bottomCorners: Bool = false
    @IBInspectable
    var leftCorners: Bool = false
    @IBInspectable
    var rightCorners: Bool = false
    
    @IBInspectable
    var cornerRadii: CGSize = .zero
    @IBInspectable
    var perfectRoundedRadius: Bool = false
    @IBInspectable
    var cornerRadius: CGFloat = 0.0
    
    // Border
    @IBInspectable
    var borderWidth: CGFloat = 0
    @IBInspectable
    var borderColor: UIColor?
    
    // Dark Mode dynamics
    @IBInspectable
    var hasShadowInDarkMode: Bool = true {
        didSet {
            updateUi()
        }
    }
    @IBInspectable
    var hasBorderInDarkMode: Bool = true {
        didSet {
            updateUi()
        }
    }
    
    // Shadow
    @IBInspectable
    var shadowRadius: CGFloat = 0.0
    @IBInspectable
    var shadowOpacity: Float = 0.0
    @IBInspectable
    var shadowOffset: CGSize = .zero
    @IBInspectable
    var shadowColor: UIColor = Color.customLabel
    
    // Blur
    @IBInspectable
    var isBlurView: Bool = false
    
    // Gradient
    @IBInspectable
    var isGradient: Bool = false
    
    @IBInspectable
    var gradColor1: UIColor = .clear
    
    @IBInspectable
    var gradColor2: UIColor = .clear
    
    @IBInspectable
    var customGradColor1: String?
    
    @IBInspectable
    var customGradColor2: String?
    
    lazy var shadowView: UIView = {
        return UIView(frame: self.frame)
    }()
    
    override var isHidden: Bool {
        didSet {
            shadowView.isHidden = isHidden
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
     
        var rectCorners: UIRectCorner = []
        
        if topCorners == true {
            rectCorners = [.topLeft, .topRight]
        } else if bottomCorners == true {
            rectCorners = [.bottomLeft, .bottomRight]
        } else if leftCorners == true {
            rectCorners = [.bottomLeft, .topLeft]
        } else if rightCorners == true {
            rectCorners = [.bottomRight, .topRight]
        }
        
        if !rectCorners.isEmpty {
            let maskPath = UIBezierPath(roundedRect: bounds,
                                        byRoundingCorners: rectCorners,
                                        cornerRadii: cornerRadii)
            let maskLayer = CAShapeLayer()
            maskLayer.frame = bounds
            maskLayer.path = maskPath.cgPath
            layer.mask = maskLayer
        }
        
        layer.masksToBounds = true
        
        let radius =  perfectRoundedRadius ? (frame.height < frame.width ? (frame.height / 2) : (frame.width / 2)) : cornerRadius
        layer.cornerRadius = radius
        
        applyShadow()
        applyBorder()
    }
    
    func applyShadow() {
        guard shadowOpacity > 0 else { shadowView.removeFromSuperview(); return }
        
        let radius = perfectRoundedRadius ? (frame.height < frame.width ? (frame.height / 2) : (frame.width / 2)) : cornerRadius
        
        shadowView.backgroundColor = .clear
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
        shadowView.layer.shadowOffset = shadowOffset
        shadowView.layer.shadowOpacity = shadowOpacity
        shadowView.layer.shadowRadius = shadowRadius
        shadowView.layer.masksToBounds = true
        shadowView.clipsToBounds = false

        self.superview?.addSubview(shadowView)
        self.superview?.bringSubviewToFront(self)
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        updateUi()
    }
    
    func updateUi() {
        if #available(iOS 13, *) {
            if traitCollection.userInterfaceStyle == .dark {
                if !hasShadowInDarkMode {
                    shadowOpacity = 0
                }
                
                if !hasBorderInDarkMode {
                    borderWidth = 0
                }
            }
        }
    }
    
    func applyBorder() {
        guard borderWidth > 0 else { return }
        
        layer.borderColor = borderColor?.cgColor
        layer.borderWidth = borderWidth
    }
}

