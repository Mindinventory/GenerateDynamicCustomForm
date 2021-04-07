//
//  TblFormView.swift
//  CommonLRF
//
//  Created by mind-288 on 3/5/21.
//

import UIKit

final class TblFormView: UITableView {
    
    //MARK: Properties
    var txtFieldModel = [FormModel]()
    var userData = [[FormModel]]()
    var userImage = [ProfileImageModel]()
    var userisChecked = [CheckBoxModel]()
    var userSwitchValue = [SwitchModel]()
    var userMultiPhoto = [MultiPhotoModel]()
    var pickerData = [String]()
    var cntryCode = [String]()
    var index = 0
    var isFromEdit = false
    var isValidate = true
    
    private var profileImg = ProfileImageModel()
    private var countryCode: String?
    private var checkBoxModel = CheckBoxModel()
    private var switchModel = SwitchModel()
    private var multiImageModel = MultiPhotoModel()
    
    // Completion Handler for User Data
    var userDataHandler: ((_ txtData: [[FormModel]], _ imgData: [ProfileImageModel], _ checkBoxData: [CheckBoxModel], _ switchData: [SwitchModel], _ userMultiPhoto: [MultiPhotoModel]) -> Void)?
    
    //MARK: awakeFromNib
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }
    
    deinit {
        print("TblFormView is deinitialized")
    }
}

//MARK:- Initialize
//MARK:-
extension TblFormView {
    
    private func initialize() {
        
        delegate = self
        dataSource = self
        estimatedRowHeight = 160.0
        rowHeight = UITableView.automaticDimension
        
        register(ProfileCell.nib, forCellReuseIdentifier: ProfileCell.identifier)
        register(InfoCell.nib, forCellReuseIdentifier: InfoCell.identifier)
        register(MobileNumberCell.nib, forCellReuseIdentifier: MobileNumberCell.identifier)
        register(CheckBoxCell.nib, forCellReuseIdentifier: CheckBoxCell.identifier)
        register(TextViewCell.nib, forCellReuseIdentifier: TextViewCell.identifier)
        register(SwitchCell.nib, forCellReuseIdentifier: SwitchCell.identifier)
        register(MultiPhotoCell.nib, forCellReuseIdentifier: MultiPhotoCell.identifier)
        register(FooterView.nib, forHeaderFooterViewReuseIdentifier: FooterView.identifier)
    }
}

//MARK:- UITableView DataSource and Delegate
//MARK:-
extension TblFormView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return txtFieldModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Check ControlType
        switch txtFieldModel[indexPath.row].controlType {
        
        case .textField:
            
            if txtFieldModel[indexPath.row].txtFieldType == .mobileNumber(true) || txtFieldModel[indexPath.row].txtFieldType == .mobileNumber(false) {
                
                if let mobNoCell = tableView.dequeueReusableCell(withIdentifier: MobileNumberCell.identifier) as? MobileNumberCell {
                    
                    if isFromEdit {
                        mobNoCell.cntryCode = countryCode
                    }
                    
                    if txtFieldModel[indexPath.row].txtFieldType == .mobileNumber(true) {
                        mobNoCell.configureCell(data: txtFieldModel[indexPath.row], code: cntryCode, flag: true)
                    } else {
                        mobNoCell.configureCell(data: txtFieldModel[indexPath.row], code: cntryCode, flag: false)
                    }
                    
                    mobNoCell.CntryCodeHandler = { [weak self] textFieldcode in
                        
                        guard let `self` = self else { return }
                        self.countryCode = textFieldcode.text
                    }
                    
                    mobNoCell.txtMobNoHandler = { [weak self] textFieldMob in
                        
                        guard let `self` = self else { return }
                        self.txtFieldModel[indexPath.row].value = textFieldMob.text
                    }
                    
                    mobNoCell.txtMobNoValidateHandler = { [weak self] isValidated in
                        
                        guard let `self` = self else { return }
                        self.isValidate = isValidated
                        self.txtFieldModel[indexPath.row].isValid = isValidated
                    }
                    
                    return mobNoCell
                }
                
            } else {
                
                if let infocell = tableView.dequeueReusableCell(withIdentifier: InfoCell.identifier) as? InfoCell {
                    
                    infocell.configureCell(data: txtFieldModel[indexPath.row], pickerData: pickerData)
                    
                    infocell.txtFieldValueHandler = { [weak self] textField in
                        
                        guard let `self` = self else { return }
                        self.txtFieldModel[indexPath.row].value = textField.text
                    }
                    
                    infocell.txtFieldValidateHandler = { [weak self] isValidated in
                        
                        guard let `self` = self else { return }
                        self.isValidate = isValidated
                        self.txtFieldModel[indexPath.row].isValid = isValidated
                    }
                    return infocell
                }
            }
            
        case .profileImage:
            
            if let profileCell = tableView.dequeueReusableCell(withIdentifier: ProfileCell.identifier) as? ProfileCell {
                
                if isFromEdit {
                    profileCell.configureCell(user: userImage[index].userImg, banner: userImage[index].bannerImg)
                }
                
                profileCell.imgUserHandler = { [weak self] image in
                    
                    guard let `self` = self else { return }
                    self.profileImg.userImg = image
                    
                    if self.isFromEdit {
                        self.userImage[self.index].userImg = image
                    }
                }
                
                profileCell.imgBannerHandler = { [weak self] image in
                    
                    guard let `self` = self else { return }
                    self.profileImg.bannerImg = image
                    
                    if self.isFromEdit {
                        self.userImage[self.index].bannerImg = image
                    }
                }
                return profileCell
            }
            
        case .checkBox:
            
            if let checkBoxCell = tableView.dequeueReusableCell(withIdentifier: CheckBoxCell.identifier) as? CheckBoxCell {
                
                if isFromEdit {
                    checkBoxCell.configureCell(isChecked: userisChecked[index].isChecked ?? false)
                    self.checkBoxModel.isChecked = userisChecked[index].isChecked
                }
                
                checkBoxCell.checkBoxCheckedHandler = { [weak self] checked in
                    
                    guard let `self` = self else { return }
                    self.checkBoxModel.isChecked = checked
                }
                return checkBoxCell
            }
            
        case .switchType:
            
            if let switchCell = tableView.dequeueReusableCell(withIdentifier: SwitchCell.identifier) as? SwitchCell {
                
                if isFromEdit {
                    switchCell.configureCell(value: userSwitchValue[index].isOn ?? true)
                }
                
                switchCell.switchHandler = { [weak self] value in
                    
                    guard let `self` = self else { return }
                    self.switchModel.isOn = value
                }
                return switchCell
            }
            
        case .textView:
            
            if let textViewCell = tableView.dequeueReusableCell(withIdentifier: TextViewCell.identifier) as? TextViewCell {
                
                textViewCell.configuareCell(info: txtFieldModel[indexPath.row], isEdit: isFromEdit)
                
                textViewCell.txtViewValueHandler = { [weak self] textView in
                    
                    guard let `self` = self else { return }
                    self.txtFieldModel[indexPath.row].value = textView.text
                }
                return textViewCell
            }
            
        case .multiPhoto:
            
            if let multiPhotoCell = tableView.dequeueReusableCell(withIdentifier: MultiPhotoCell.identifier) as? MultiPhotoCell {
                
                if isFromEdit {
                    multiPhotoCell.configureCell(images: userMultiPhoto[index].images ?? [UIImage]())
                }
                
                multiPhotoCell.multiImgHandler = { [weak self] imgs in
                    
                    guard let `self` = self else { return }
                    self.multiImageModel.images = imgs
                    
                    if self.isFromEdit {
                        self.userMultiPhoto[self.index].images = imgs
                    }
                }
                return multiPhotoCell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        //FooterView
        if let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: FooterView.identifier) as? FooterView {
            
            //Submit Button
            footerView.btnSubmit.touchUpInside { [weak self] sender in
                
                guard let `self` = self else { return }
                
                self.validateData()
            }
            return footerView
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CScreenWidth * ( 60.0 / 320.0)
    }
}

//MARK:- Helper Methods
//MARK:-
extension TblFormView {
    
    // Validate Data
    private func validateData() {
        
        // Get All TextFields Values
        guard let indexName = txtFieldModel.firstIndex(where: { $0.placeHolder == placeHolderName }) else { return }
        let name = txtFieldModel[indexName].value ?? ""
        
        guard let indexEmail = txtFieldModel.firstIndex(where: { $0.placeHolder == placeHolderEmail }) else { return }
        let email = txtFieldModel[indexEmail].value ?? ""
        
        guard let indexPassword = txtFieldModel.firstIndex(where: { $0.placeHolder == placeHolderPassword }) else { return }
        let password = txtFieldModel[indexPassword].value ?? ""
        
        guard let indexMobNo = txtFieldModel.firstIndex(where: { $0.placeHolder == placeHolderMobNo }) else { return }
        let mobNO = txtFieldModel[indexMobNo].value ?? "123"
        
        let isCheckBoxChecked = checkBoxModel.isChecked ?? false
        
        // Validation
        if name.isEmpty || email.isEmpty || password.isEmpty || mobNO.isEmpty {
            self.parentContainerViewController()?.alertView(title: "", message: "Please Enter Required Data", style: .alert, actions: [.Ok], handler: nil)
            
        } else if isCheckBoxChecked == false {
            
            self.parentContainerViewController()?.alertView(title: "", message: "Please Check Terms and Conditions", style: .alert, actions: [.Ok], handler: nil)
            
        } else if isValidate == false {
            
            self.parentContainerViewController()?.alertView(title: "", message: "Please Enter Valid Data", style: .alert, actions: [.Ok], handler: nil)
            
        } else {
            submitData()
        }
    }
    
    // Check isfrom Edit and Submit Data
    private func submitData() {
        
        if isFromEdit {
            
            userData[index] = txtFieldModel
            userisChecked[index] = checkBoxModel
            userSwitchValue[index] = switchModel
            
            userDataHandler?(userData, userImage, userisChecked, userSwitchValue, userMultiPhoto)
            
            self.parentContainerViewController()?.alertView(title: "", message: "Data Edited", style: .alert, actions: [.Ok], handler: { [weak self] action in
                
                guard let `self` = self else { return }
                
                self.parentContainerViewController()?.navigationController?.popToRootViewController(animated: true)
            })
            
        } else {
            
            userData.append(txtFieldModel)
            userImage.append(profileImg)
            userMultiPhoto.append(multiImageModel)
            userisChecked.append(checkBoxModel)
            userSwitchValue.append(switchModel)
            
            userDataHandler?(userData, userImage, userisChecked, userSwitchValue, userMultiPhoto)
            
            self.parentContainerViewController()?.alertView(title: "", message: "Data Submitted", style: .alert, actions: [.Ok], handler: { action in
            })
        }
    }
}
