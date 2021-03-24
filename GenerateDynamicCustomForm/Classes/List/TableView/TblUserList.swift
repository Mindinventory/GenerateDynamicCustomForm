//
//  TblUserList.swift
//  CommonLRF
//
//  Created by mind-288 on 3/9/21.
//

import UIKit

final class TblUserList: UITableView {
    
    var userData = [[FormModel]]()
    var userImage = [ProfileImageModel]()
    var userisChecked = [CheckBoxModel]()
    var userSwitchValue = [SwitchModel]()
    var userMultiPhoto = [MultiPhotoModel]()
    
    private var user = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }
}

//MARK:- Initialize
//MARK:-
extension TblUserList {
    
    private func initialize() {
        
        dataSource = self
        delegate = self
        register(ListCell.nib, forCellReuseIdentifier: ListCell.identifier)
    }
}

//MARK:- UITableView Datasource and Delegate
//MARK:-
extension TblUserList: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let userCell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier) as? ListCell {
            
            guard let index = userData[indexPath.row].firstIndex(where: { $0.placeHolder == "Name*" }) else { return UITableViewCell() }
            
            userCell.configureCell(data: userData[indexPath.row][index].value)
            
            return userCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let formVC = CMainStoryboard.instantiateViewController(withIdentifier: FormVC.storyboardID) as? FormVC {
            
            formVC.isFromEdit = true
            formVC.txtFieldData = userData
            formVC.index = indexPath.row
            formVC.userImage = userImage
            formVC.userisChecked = userisChecked
            formVC.userSwitchValue = userSwitchValue
            formVC.userMultiPhoto = userMultiPhoto
            
            self.parentContainerViewController()?.navigationController?.pushViewController(formVC, animated: true)
        }
    }
}
