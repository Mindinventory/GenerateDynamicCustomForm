//
//  UITableViewCell+Extension.swift
//  SetupApp
//
//  Created by mac-00020 on 11/12/19.
//  Copyright © 2019 mac-00020. All rights reserved.
//

import Foundation
import UIKit

extension  UITableViewCell {
    static var nib:UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension  UITableViewHeaderFooterView {
    static var nib:UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView {
    static var nib:UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
