//
//  ExtensionsUIView.swift
//
//  Created by mac-0005 on 07/01/2020.
//  Copyright © 2020. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Extension of UIView For giving the round shape to any UIView.
extension UIView {
    
    @IBInspectable fileprivate var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
    }
    
    @IBInspectable fileprivate var borderColor: UIColor? {
        get {
            guard let borderColor = self.layer.borderColor else { return nil }
            return UIColor(cgColor: borderColor)
        } set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable fileprivate var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        } set {
            self.layer.borderWidth = newValue
        }
    }
    
    func roundView() {
        
        layer.cornerRadius = CViewHeight > CViewWidth
            ? CViewWidth/2.0
            : CViewHeight/2.0
        layer.masksToBounds = true
    }
}


extension UIView {
    
    func shadow(color: UIColor, shadowOffset: CGSize, shadowRadius: CGFloat, shadowOpacity: Float) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        
        self.layer.shouldRasterize = true
    }
}

extension UIView {
    
    var CViewSize: CGSize {
        return self.frame.size
    }
    var CViewWidth: CGFloat {
        return self.CViewSize.width
    }
    var CViewHeight: CGFloat {
        return self.CViewSize.height
    }
}
