//
//  TblForm.swift
//  GenerateDynamicCustomForm
//
//  Created by mind-288 on 3/23/21.
//

import UIKit

class GenericCollectionView: UICollectionView {
    
    override var contentSize:CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
