//
//  MultiPhotoCollCell.swift
//  CommonLRF
//
//  Created by mind-288 on 3/16/21.
//

import UIKit

final class MultiPhotoCollCell: UICollectionViewCell {
    
    @IBOutlet weak private var imgPhotos: UIImageView!
}

//MARK:- Configure Cell
//MARK:-
extension MultiPhotoCollCell {
    
    func configureCell(image: UIImage?) {
        
        imgPhotos.image = image
    }
}
