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
extension CollMultiplePhotos: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return multiImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let multiPhotoCollCell = collectionView.dequeueReusableCell(withReuseIdentifier: MultiPhotoCollCell.identifier, for: indexPath) as? MultiPhotoCollCell {
            
            multiPhotoCollCell.configureCell(image: multiImages[indexPath.row])
            
            return multiPhotoCollCell
        }
        return UICollectionViewCell()
    }
}
