//
//  CollMultiplePhotos.swift
//  CommonLRF
//
//  Created by mind-288 on 3/16/21.
//

import UIKit

final class CollMultiplePhotos: UICollectionView {
    
    var multiImages = [UIImage]() {
        didSet {
            reloadData()
        }
    }
    
    // Completion Handler For UIImage's Value Changed
    var multiImgRemovalHandler: ((_ images: [UIImage]) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }
}

//MARK:- Initialize
//MARK:-
extension CollMultiplePhotos {
    
    private func initialize() {
        
        dataSource = self
        delegate = self
        register(MultiPhotoCollCell.nib, forCellWithReuseIdentifier: MultiPhotoCollCell.identifier)
    }
}

//MARK:- Initialize
//MARK:-
extension CollMultiplePhotos: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return multiImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let multiPhotoCollCell = collectionView.dequeueReusableCell(withReuseIdentifier: MultiPhotoCollCell.identifier, for: indexPath) as? MultiPhotoCollCell {
            
            multiPhotoCollCell.configureCell(image: multiImages[indexPath.row])
            
            multiPhotoCollCell.btnRemove.touchUpInside { [weak self] sender in
                
                guard let `self` = self else { return }
                self.multiImages.remove(at: indexPath.row)
                self.reloadData()
                self.multiImgRemovalHandler?(self.multiImages)
            }
            
            return multiPhotoCollCell
        }
        return UICollectionViewCell()
    }
}
