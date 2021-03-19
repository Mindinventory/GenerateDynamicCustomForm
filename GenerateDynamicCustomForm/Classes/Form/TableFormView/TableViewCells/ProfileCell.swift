//
//  ProfileCell.swift
//  CommonLRF
//
//  Created by mind-288 on 3/5/21.
//

import UIKit

final class ProfileCell: UITableViewCell {

    @IBOutlet weak private var btnBanner: UIButton!
    @IBOutlet weak private var btnProfile: UIButton!
    @IBOutlet weak private var imgBanner: UIImageView!
    @IBOutlet weak private var imgUser: UIImageView!
    
    private var img = UIImage()
    
    // Completion Handler For UIImage's Value Changed
    var imgUserHandler: ((_ image: UIImage) -> Void)?
    var imgBannerHandler: ((_ image: UIImage) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }
    
    deinit {
        print("ProfileCell is deinitialized")
    }
}

//MARK:- Initialize
//MARK:-
extension ProfileCell {
    
    private func initialize() {
        
        CGCDMainThread.async { [weak self] in
            
            guard let `self` = self else { return }
            self.btnProfile.roundView()
            self.btnBanner.roundView()
            self.imgUser.roundView()
        }
    }
    
    func configureCell(user: UIImage?, banner: UIImage?) {
        
        imgUser.image = user ?? UIImage(named: "ic_camera")
        imgBanner.image = banner ?? UIImage(named: "ic_banner")
    }
}

//MARK:- Action
//MARK:-
extension ProfileCell {
    
    @IBAction func onAdd(_ sender: UIButton) {
        
        if sender.tag == 1 { // For Profile Image
            
            img = imgUser.image ?? UIImage()
            
            MediaManager.shared.presentImagePickerController(mediaType: [.photoLibrary("Photos"), .camera("Camera")], commpletion: { [weak self]
                (image, info) in
                
                guard let `self` = self else { return }
                
                if image == nil {
                    self.imgUser.image = self.img
                    self.imgUserHandler?(self.img)
                } else {
                    self.imgUser.image = image
                    self.imgUserHandler?(image ?? UIImage())
                }
            })
            
        } else { // For Profile Banner
            
            img = imgBanner.image ?? UIImage()
            
            MediaManager.shared.presentImagePickerController(mediaType: [.photoLibrary("Photos"), .camera("Camera")], commpletion: { [weak self]
                (image, info) in
                
                guard let `self` = self else { return }
                
                if image == nil {
                    self.imgBanner.image = self.img
                    self.imgBannerHandler?(self.img)
                } else {
                    self.imgBanner.image = image
                    self.imgBannerHandler?(image ?? UIImage())
                }
            })
        }
    }
}
