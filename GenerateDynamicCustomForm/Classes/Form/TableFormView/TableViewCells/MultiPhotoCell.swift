//
//  MultiPhotoCell.swift
//  CommonLRF
//
//  Created by mind-288 on 3/15/21.
//

import UIKit

final class MultiPhotoCell: UITableViewCell {
    
    @IBOutlet weak private var btnAdd: UIButton!
    @IBOutlet weak private var lblPhotosCount: UILabel!
    @IBOutlet weak private var collMultiplePhoto: CollMultiplePhotos!
    
    // Completion Handler For UIImage's Value Changed
    var multiImgHandler: ((_ images: [UIImage]) -> Void)?
    
    private var images = [UIImage]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initializeCollView(multiImg: images)
        
        CGCDMainThread.async { [weak self] in
            
            guard let `self` = self else { return }
            self.btnAdd.roundView()
            self.btnAdd.shadow(color: .black, shadowOffset: CGSize(width: 3.0, height: 3.0), shadowRadius: 8.0)
        }
    }
}

//MARK:- Configure
//MARK:-
extension MultiPhotoCell {
    
    func configureCell(images: [UIImage]) {
        
        lblPhotosCount.text = "\(images.count) Photos Selected"
        
        CGCDMainThread.async { [weak self] in
            
            guard let `self` = self else { return }
            
            if images.count > 0 {
                self.lblPhotosCount.textColor = .white
            } else {
                self.lblPhotosCount.textColor = UIColor.white.withAlphaComponent(0.6)
            }
        }
        initializeCollView(multiImg: images)
    }
}

//MARK:- Action
//MARK:-
extension MultiPhotoCell {
    
    @IBAction private func onAdd(_ sender: UIButton) {
        
        MediaManager.shared.presentImagePickerController(mediaType: [.photoLibrary("Photos"), .camera("Camera")], commpletion: { [weak self]
            (image, info) in
            
            guard let `self` = self else { return }
            
            if image == nil {
                
            } else {
                self.images.append(image ?? UIImage())
                self.lblPhotosCount.text = "\(self.images.count) Photos Selected"
                self.lblPhotosCount.textColor = .white
                self.initializeCollView(multiImg: self.images)
                self.multiImgHandler?(self.images)
            }
        })
    }
}

//MARK:- CollectionView MultiplePhoto
//MARK:-
extension MultiPhotoCell {
    
    private func initializeCollView(multiImg: [UIImage]) {
        
        collMultiplePhoto.multiImages = multiImg
    }
}
