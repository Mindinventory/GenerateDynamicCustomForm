//
//  UIViewController+Alert.swift
//  SetupApp
//
//  Created by mac-0005 on 08/01/20.
//  Copyright © 2020 mac-00020. All rights reserved.
//

import Foundation
import UIKit

typealias alertActionHandler = ((UIAlertAction) -> ())?

public enum AAction: Equatable {
    
    case Ok
    case Cancel
    case Custom(title:String)
    
    var title : String {
        switch self {
        case .Ok:
            return "Ok"
        case .Cancel:
            return "Cancel"
        case .Custom(let title):
            return title
        }
    }
    
    var style: UIAlertAction.Style {
        switch self {
        case .Cancel:
            return .cancel
        default:
            return .default
        }
    }
}

// MARK: - Extension of UIViewController For AlertView with Different Numbers of Buttons -
extension UIViewController {
    
    func alertView(title: String? = nil, message: String? = nil, style: UIAlertController.Style = .alert, actions: [AAction] = [],  handler: ((AAction) -> Void)? = nil) {
        
        var _actions = actions
        if actions.isEmpty {
            _actions.append(AAction.Ok)
        }
        var arrAction : [UIAlertAction] = []
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let onSelect : ((UIAlertAction) -> Void)? = { (alert) in
            guard let index = arrAction.firstIndex(of: alert) else {
                return
            }
            handler?(_actions[index])
        }
        for action in _actions {
            arrAction.append(UIAlertAction(title: action.title, style: action.style, handler: onSelect))
        }
        let _ = arrAction.map({alertController.addAction($0)})
        self.present(alertController, animated: true, completion: nil)
    }
}

extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
}

// MARK: - Extension of UIApplication -

extension UIApplication {
    
    static var appDelegate: AppDelegate? {
        return CSharedApplication.delegate as? AppDelegate
    }
    
    func topMostVC(viewController: UIViewController? = CSharedApplication.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationViewController = viewController as? UINavigationController {
            return CSharedApplication.topMostVC(viewController: navigationViewController.visibleViewController)
        }
        if let tabBarViewController = viewController as? UITabBarController {
            if let selectedViewController = tabBarViewController.selectedViewController {
                return CSharedApplication.topMostVC(viewController: selectedViewController)
            }
        }
        if let presentedViewController = viewController?.presentedViewController {
            return CSharedApplication.topMostVC(viewController: presentedViewController)
        }
        return viewController
    }
}
