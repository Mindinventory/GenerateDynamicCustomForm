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
        navigationController?.navigationBar.topItem?.title = ""
        
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
                
                FormModel(controlType: .profileImage), // Profile Image
                
                FormModel(controlType: .textField, txtFieldType: .normal, value: "", placeHolder: placeHolderName, placeHolder2: "John Doe", placeHolderColor: .darkGray, leftImgView: "ic_user", rightImgView: nil, isEnabled: true, isSecure: false, keyboardType: .default, isValid: true), // Name
                
                FormModel(controlType: .textField, txtFieldType: .normal, value: "", placeHolder: placeHolderEmail, placeHolder2: "name@example.com", placeHolderColor: .darkGray, leftImgView: "ic_email", rightImgView: nil, isEnabled: true, isSecure: false, keyboardType: .emailAddress, isValid: true), // Email
                
                FormModel(controlType: .textField, txtFieldType: .password, value: "", placeHolder: placeHolderPassword, placeHolder2: "*******", placeHolderColor: .darkGray, leftImgView: "ic_password", rightImgView: nil, isEnabled: true, isSecure: true, keyboardType: .default, isValid: true), // Password
                
                FormModel(controlType: .textField, txtFieldType: .mobileNumber(false), value: "", placeHolder: placeHolderMobNo, placeHolder2: "1234567890", placeHolderColor: .darkGray, leftImgView: nil, rightImgView: nil, isEnabled: true, isSecure: false, keyboardType: .phonePad, isValid: true), // Mobile number
                
                FormModel(controlType: .textView, value: "", placeHolder: placeHolderAddress, placeHolder2: "21, Satelite Shopping Centre.", placeHolderColor: .darkGray, isEnabled: true, isSecure: false, keyboardType: .default, isValid: true), // Address (TextView)
                
                FormModel(controlType: .textField, txtFieldType: .dob, value: "", placeHolder: placeHolderDob, placeHolder2: "DD/MM/YYYY", placeHolderColor: .darkGray, leftImgView: "ic_calender", rightImgView: nil, isEnabled: true, isSecure: false, keyboardType: .default, isValid: true), // Date of Birth (Date Picker)
                
                FormModel(controlType: .textField, txtFieldType: .actionSheet, value: "", placeHolder: placeHolderGender, placeHolder2: "Select Male or Female", placeHolderColor: .darkGray, leftImgView: "ic_gender", rightImgView: nil, isEnabled: true, isSecure: false, keyboardType: .default, isValid: true), // Gender (Action Sheet)
                
                FormModel(controlType: .textField, txtFieldType: .selection(false), value: "", placeHolder: placeHolderCountry, placeHolder2: "Select Conutry", placeHolderColor: .darkGray, leftImgView: "ic_flag", rightImgView: nil, isEnabled: true, isSecure: false, keyboardType: .default, isValid: true), // Countries India or Other
                
                FormModel(controlType: .textField, txtFieldType: .selection(true), value: "", placeHolder: placeHolderHobbies, placeHolder2: "Select Hobbies", placeHolderColor: .darkGray, leftImgView: "ic_food", rightImgView: nil, isEnabled: true, isSecure: false, keyboardType: .default, isValid: true), // Hobbies (Multiple Selection View)
                
                FormModel(controlType: .textField,txtFieldType: .picker, value: "", placeHolder: placeHolderDept, placeHolder2: "Select Department", placeHolderColor: .darkGray, leftImgView: "ic_dept", rightImgView: nil, isEnabled: true, isSecure: false, keyboardType: .default, isValid: true), // Department (Picker)
                
                FormModel(controlType: .multiPhoto), // Multiple Photos
                
                FormModel(controlType: .switchType), // Notifications (Switch)
                
                FormModel(controlType: .checkBox) // Terms and Conditions (CheckBox)
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
