//
//  ViewController.swift
//  CommonLRF
//
//  Created by mac-00015 on 03/03/21.
//

import UIKit

final class FormVC: UIViewController {
    
    @IBOutlet weak private var tblFormView: TblFormView!
    
    var txtFieldData = [[FormModel]]()
    var userImage = [ProfileImageModel]()
    var userisChecked = [CheckBoxModel]()
    var userSwitchValue = [SwitchModel]()
    var userMultiPhoto = [MultiPhotoModel]()
    
    var isFromHome = false
    var isFromEdit = false
    var index = 0
    
    private var country = ""
    private var hobbies = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    deinit {
        print("FormVC is deinitialized")
    }
}

//MARK:- Initialize
//MARK:-

extension FormVC {
    
    private func initialize() {
        
        title = "Form"
        
        if isFromEdit {
            
            tblFormView.userData = txtFieldData
            tblFormView.txtFieldModel = txtFieldData[index]
            tblFormView.userImage = userImage
            tblFormView.userisChecked = userisChecked
            tblFormView.userSwitchValue = userSwitchValue
            tblFormView.userMultiPhoto = userMultiPhoto
            tblFormView.index = index
            
        } else {
            
            if isFromHome {
                
                tblFormView.userData = txtFieldData
                tblFormView.userImage = userImage
                tblFormView.userisChecked = userisChecked
                tblFormView.userSwitchValue = userSwitchValue
                tblFormView.userMultiPhoto = userMultiPhoto
            }
            
            tblFormView.txtFieldModel = [
                
                FormModel(formType: .profileImage), // Profile Image
                
                FormModel(formType: .textField, txtFieldType: .normal, value: "", placeHolder: placeHolderName, placeHolderColor: UIColor.white.withAlphaComponent(0.6), leftImgView: "ic_user", rightImgView: nil, isEnabled: true, keyboardType: .default), // Name
                
                FormModel(formType: .textField, txtFieldType: .normal, value: "", placeHolder: placeHolderEmail, placeHolderColor: UIColor.white.withAlphaComponent(0.6), leftImgView: "ic_email", rightImgView: nil, isEnabled: true, keyboardType: .emailAddress), // Email
                
                FormModel(formType: .textField, txtFieldType: .password, value: "", placeHolder: placeHolderPassword, placeHolderColor: UIColor.white.withAlphaComponent(0.6), leftImgView: "ic_password", rightImgView: nil, isEnabled: true, isSecure: true, keyboardType: .default), // Password
                
                FormModel(formType: .textField, txtFieldType: .mobileNumber(false), value: "", placeHolder: placeHolderMobNo, placeHolderColor: UIColor.white.withAlphaComponent(0.6), leftImgView: nil, rightImgView: nil, isEnabled: true, keyboardType: .phonePad), // Mobile number
                
                FormModel(formType: .textView, value: "", placeHolder: placeHolderAddress, placeHolderColor: UIColor.white.withAlphaComponent(0.6), isEnabled: true, keyboardType: .default), // Address (TextView)
                
                FormModel(formType: .textField, txtFieldType: .dob, value: "", placeHolder: placeHolderDob, placeHolderColor: UIColor.white.withAlphaComponent(0.6), leftImgView: "ic_calender"), // Date of Birth (Date Picker)
                
                FormModel(formType: .textField, txtFieldType: .actionSheet, value: "", placeHolder: placeHolderGender, placeHolderColor: UIColor.white.withAlphaComponent(0.6), leftImgView: "ic_gender"), // Gender (Action Sheet)
                
                FormModel(formType: .textField, txtFieldType: .selection(false), value: "", placeHolder: placeHolderCountry, placeHolderColor: UIColor.white.withAlphaComponent(0.6), leftImgView: "ic_flag"), // Countries India or Other
                
                FormModel(formType: .textField, txtFieldType: .selection(true), value: "", placeHolder: placeHolderHobbies, placeHolderColor: UIColor.white.withAlphaComponent(0.6), leftImgView: "ic_food"), // Hobbies (Multiple Selection View)
                
                FormModel(formType: .textField, txtFieldType: .picker, value: "", placeHolder: placeHolderDept, placeHolderColor: UIColor.white.withAlphaComponent(0.6), leftImgView: "ic_dept", rightImgView: nil, isEnabled: true, keyboardType: .default), // Department (Picker)
                
                FormModel(formType: .multiPhoto), // Multiple Photos
                
                FormModel(formType: .switchType), // Notifications (Switch)
                
                FormModel(formType: .checkBox) // Terms and Conditions (CheckBox)
            ]
        }
        
        tblFormView.userDataHandler = { [weak self] (userData, userImage, userIsChecked, userSwitchValue, userMultiPhoto) in
            
            guard let `self` = self else { return }
            
            if let homeVC = self.navigationController?.viewControllers.first as? HomeVC {
                
                homeVC.userData = userData
                homeVC.userImage = userImage
                homeVC.userisChecked = userIsChecked
                homeVC.userSwitchValue = userSwitchValue
                homeVC.userMultiPhoto = userMultiPhoto
            }
        }
        
        tblFormView.isFromEdit = isFromEdit
        tblFormView.pickerData = ["iOS", "Android", "Web", "Design", "Sales", "HR"]
        tblFormView.cntryCode = ["+91","+1 340","+299","+39","+44","+598","+64"]
    }
}
