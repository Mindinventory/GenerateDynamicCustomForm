//
//  UIButton+Extension.swift
//
//  Created by mac-0005 on 07/01/2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit

typealias genericTouchUpInsideHandler<T> = ((T) -> ())

// MARK: - Extension of UIButton For TouchUpInside Handler.
extension UIButton {
    
    /// This Private Structure is used to create all AssociatedObjectKey which will be used within this extension.
    private struct AssociatedObjectKey {
        static var genericTouchUpInsideHandler = "genericTouchUpInsideHandler"
    }
    
    /// This method is used for UIButton's touchUpInside Handler
    /// - Parameter genericTouchUpInsideHandler: genericTouchUpInsideHandler will give you object of UIButton.
    func touchUpInside(genericTouchUpInsideHandler: @escaping genericTouchUpInsideHandler<UIButton>) {
        
        objc_setAssociatedObject(
            self,
            &AssociatedObjectKey.genericTouchUpInsideHandler,
            genericTouchUpInsideHandler,
            .OBJC_ASSOCIATION_RETAIN
        )
        
        self.addTarget(
            self,
            action: #selector(handleButtonTouchEvent(sender:)),
            for: .touchUpInside
        )
        
    }
    
    /// This Private method is used for handle the touch event of UIButton.
    ///
    /// - Parameter sender: UIButton.
    @objc private func handleButtonTouchEvent(sender: UIButton) {
        
        if let genericTouchUpInsideHandler = objc_getAssociatedObject(self, &AssociatedObjectKey.genericTouchUpInsideHandler) as?  genericTouchUpInsideHandler<UIButton> {
            genericTouchUpInsideHandler(sender)
        }
    }
}
