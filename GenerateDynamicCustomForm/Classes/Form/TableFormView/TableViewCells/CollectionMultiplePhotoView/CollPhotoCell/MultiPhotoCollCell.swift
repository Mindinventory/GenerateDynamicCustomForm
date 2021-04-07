//
//  MultiPhotoCollCell.swift
//  CommonLRF
//
//  Created by mind-288 on 3/16/21.
//

import UIKit

final class MultiPhotoCollCell: UICollectionViewCell {
    
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak private var imgPhotos: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }
}

//MARK:- Configure Cell
//MARK:-
extension MultiPhotoCollCell {
    
    private func initialize() {
        
        CGCDMainThread.async { [weak self] in
            
            guard let `self` = self else { return }
            self.btnRemove.roundView()
        }
    }
    
    func configureCell(image: UIImage?) {
        
        imgPhotos.image = image
    }
}
