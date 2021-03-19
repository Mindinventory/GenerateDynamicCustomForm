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
        
        navigationController?.navigationBar.shadowImage = UIImage()
        initialize()
    }
    
    deinit {}
}

//MARK:- Action
//MARK:-
extension HomeVC {
    
    private func initialize() {
        
        btnShow.shadow(color: .black, shadowOffset: CGSize(width: 5.0, height: 5.0), shadowRadius: 10.0)
        btnRegister.shadow(color: .black, shadowOffset: CGSize(width: 5.0, height: 5.0), shadowRadius: 10.0)
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
