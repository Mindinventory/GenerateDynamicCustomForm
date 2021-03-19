//
//  InfoCell.swift
//  CommonLRF
//
//  Created by mind-288 on 3/5/21.
//

import UIKit

final class InfoCell: UITableViewCell {
    
    @IBOutlet weak private var btnSelection: UIButton!
    @IBOutlet weak private var btnPassword: UIButton!
    @IBOutlet weak private var txtField: UITextField!
    
    var isValidate: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        txtField.delegate = self
    }
    
    var formType = TextFieldType.normal
    
    // Completion Handler For TextField's Value Changed
    var txtFieldValueHandler: ((_ txtField: UITextField) -> Void)?
    var txtFieldValidateHandler: ((_ isValid: Bool) -> Void)?
    
    deinit {
        print("InfoCell is deinitialized")
    }
}

//MARK:- Configure Cell
//MARK:-
extension InfoCell {
    
    // Configure Cell According to TextField Type
    func configureCell(data: FormModel, pickerData: [String], isValid: Bool) {
        
        formType = data.txtFieldType ?? .normal
        
        btnPassword.isHidden = true
        btnSelection.isHidden = true
        
        if isValid {
            txtField.layer.borderColor = UIColor.init(red: 235/255, green: 231/255, blue: 186/255, alpha: 1.0).cgColor
            txtField.text = data.value
            txtField.placeholder = data.placeHolder
            txtField.placeholderColor = data.placeHolderColor
            
        } else {
            
            if txtField.keyboardType == .emailAddress {
                
                txtField.text = ""
                txtField.placeholder = "Please Enter Valid Email"
                txtField.placeholderColor = UIColor.white.withAlphaComponent(0.6)
                
            } else {
                txtField.placeholder = "Please Enter Value"
                txtField.placeholderColor = UIColor.white.withAlphaComponent(0.6)
            }
        }
        
        txtField.keyboardType = data.keyboardType ?? .default
        txtField.isSecureTextEntry = data.isSecure ?? false
        txtField.setupLeftImageView(img: UIImage(named: data.leftImgView ?? ""))
        
        switch data.placeHolder {
        
        case placeHolderPassword:
            
            btnPassword.isHidden = false
            
        case placeHolderDob:
            
            if #available(iOS 13.4, *) {
                txtField.setDatePickerStyle()
            }
            
            txtField.setDatePickerMode(mode: .date)
            txtField.setMaximumDate(maxDate: Date())
            
            txtField.setDatePickerWithDateFormate(dateFormate: "dd/MM/yyyy", defaultDate: Date(), isPrefilledDate: true, selectedDateHandler: { date in
            })
            
        case placeHolderDept:
            
            txtField.setPickerData(arrPickerData: pickerData, pickerDataHandler: { [weak self]  (select, index, component) in
                guard let `self` = self else { return }
                self.txtField.text = select as? String
            })
            
        case placeHolderGender, placeHolderHobbies, placeHolderCountry:
            
            btnSelection.isHidden = false
            
        default:
            break
        }
    }
}

//MARK:- UITextFieldDelegate
//MARK:-
extension InfoCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if txtField.text == "" && txtField.keyboardType != .emailAddress {
            
            txtField.placeholder = "Please Enter Value"
            txtField.placeholderColor = UIColor.white.withAlphaComponent(0.6)
            txtField.layer.borderColor = UIColor.red.cgColor
            isValidate = false
            txtFieldValidateHandler?(isValidate ?? false)
            txtField.shake()
            
        } else {
            
            if txtField.keyboardType == .emailAddress {
                
                guard let txtEmail = txtField.text else { return }
                
                if txtEmail.isValidEmail == false {
                    txtField.text = ""
                    txtField.placeholder = "Please Enter Valid Email"
                    txtField.layer.borderColor = UIColor.red.cgColor
                    txtField.placeholderColor = UIColor.white.withAlphaComponent(0.6)
                    isValidate = false
                    txtFieldValidateHandler?(isValidate ?? false)
                    txtField.shake()
                    
                } else {
                    isValidate = true
                    txtField.layer.borderColor = UIColor.init(red: 235/255, green: 231/255, blue: 186/255, alpha: 1.0).cgColor
                    txtFieldValidateHandler?(isValidate ?? true)
                }
            } else {
                isValidate = true
                txtField.layer.borderColor = UIColor.init(red: 235/255, green: 231/255, blue: 186/255, alpha: 1.0).cgColor
                txtFieldValidateHandler?(isValidate ?? true)
            }
        }
    }
}

//MARK:- Action
//MARK:-
extension InfoCell {
    
    @IBAction func onTxtFieldValueChanged(_ sender: UITextField) {
        
        if txtFieldValueHandler != nil {
            txtFieldValueHandler?(txtField)
        }
    }
    
    @IBAction private func onPassword(_ sender: UIButton) {
        
        if !sender.isSelected {
            
            btnPassword.setImage(UIImage(named: "ic_eye_open"), for: .normal)
            txtField.isSecureTextEntry = false
            sender.isSelected.toggle()
            
        } else {
            
            btnPassword.setImage(UIImage(named: "ic_eye_close"), for: .normal)
            txtField.isSecureTextEntry = true
            sender.isSelected.toggle()
        }
    }
    
    @IBAction func onSelection(_ sender: UIButton) {
        
        switch formType {
        
        case .actionSheet:
            
            self.parentContainerViewController()?.alertView(title: "Select Gender", message: "", style: .actionSheet, actions: [.Custom(title: "Male"), .Custom(title: "Female"), .Cancel], handler: { [weak self] action in
                
                guard let `self` = self else { return }
                
                if action.title != "Cancel" {
                    self.txtField.text = action.title
                    if self.txtFieldValueHandler != nil {
                        self.txtFieldValueHandler?(self.txtField)
                    }
                }
            })
            
        case .selection(let selection):
            
            MultiSelectionVC.showPopup(parentVC: self.parentContainerViewController() ?? UIViewController(), isMultiple: selection ?? false)
            
            guard let multi = selection else { return }
            
            if multi {
                
                MultiSelectionVC.hobbiesDataHandler = { [weak self] hobbies in
                    
                    guard let `self` = self else { return }
                    self.txtField.text = hobbies.joined(separator: ", ")
                    if self.txtFieldValueHandler != nil {
                        self.txtFieldValueHandler?(self.txtField)
                    }
                }
            } else {
                
                MultiSelectionVC.countryDataHandler = { [weak self] country in
                    
                    guard let `self` = self else { return }
                    self.txtField.text = country
                    if self.txtFieldValueHandler != nil {
                        self.txtFieldValueHandler?(self.txtField)
                    }
                }
            }
            
        default:
            break
        }
    }
}
extension String {
    
    var isValidEmail: Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let predicate = NSPredicate(
            format:"SELF MATCHES %@",
            emailRegEx
        )
        
        return predicate.evaluate(with:self)
    }
}
