//
//  ListView.swift
//  CommonLRF
//
//  Created by mind-288 on 3/9/21.
//

import UIKit

final class ListVC: UIViewController {
    
    @IBOutlet weak private var tblUserList: TblUserList!
    
    var userData = [[FormModel]]()
    var userImage = [ProfileImageModel]()
    var userisChecked = [CheckBoxModel]()
    var userSwitchValue = [SwitchModel]()
    var userMultiPhoto = [MultiPhotoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
}

//MARK:- Initialize
//MARK:-
extension ListVC {
    
    private func initialize() {
        
        title = "Users"
        
        tblUserList.userData = userData
        tblUserList.userImage = userImage
        tblUserList.userisChecked = userisChecked
        tblUserList.userSwitchValue = userSwitchValue
        tblUserList.userMultiPhoto = userMultiPhoto
    }
}
