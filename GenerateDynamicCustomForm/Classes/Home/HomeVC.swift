//
//  HomeVC.swift
//  CommonLRF
//
//  Created by mind-288 on 3/8/21.
//

import UIKit

final class HomeVC: UIViewController {
    
    @IBOutlet weak private var btnShow: UIButton!
    @IBOutlet weak private var btnRegister: UIButton!
    
    var userData = [[FormModel]]()
    var userImage = [ProfileImageModel]()
    var userisChecked = [CheckBoxModel]()
    var userSwitchValue = [SwitchModel]()
    var userMultiPhoto = [MultiPhotoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    deinit {}
}

//MARK:- Action
//MARK:-
extension HomeVC {
    
    private func initialize() {
        
        navigationController?.navigationBar.shadowImage = UIImage()
//        let img = UIImage(named: "img5")?.alpha(0.8)
//        navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        btnShow.shadow(color: .black, shadowOffset: CGSize(width: 5.0, height: 5.0), shadowRadius: 8.0, shadowOpacity: 0.5)
        btnRegister.shadow(color: .black, shadowOffset: CGSize(width: 5.0, height: 5.0), shadowRadius: 8.0, shadowOpacity: 0.5)
    }
}

extension UIImage {

    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}

//MARK:- Action
//MARK:-
extension HomeVC {
    
    @IBAction func onRegister(_ sender: UIButton) {
        
        if let formVC = CMainStoryboard.instantiateViewController(withIdentifier: FormVC.storyboardID) as? FormVC {
            
            formVC.isFromHome = true
            formVC.txtFieldData = userData
            formVC.userImage = userImage
            formVC.userisChecked = userisChecked
            formVC.userSwitchValue = userSwitchValue
            formVC.userMultiPhoto = userMultiPhoto
            self.navigationController?.pushViewController(formVC, animated: true)
        }
    }
    
    @IBAction func onShow(_ sender: UIButton) {
        
        if let listVC = CMainStoryboard.instantiateViewController(withIdentifier: ListVC.storyboardID) as? ListVC {
            
            listVC.userData = userData
            listVC.userImage = userImage
            listVC.userisChecked = userisChecked
            listVC.userSwitchValue = userSwitchValue
            listVC.userMultiPhoto = userMultiPhoto
            self.navigationController?.pushViewController(listVC, animated: true)
        }
    }
}
