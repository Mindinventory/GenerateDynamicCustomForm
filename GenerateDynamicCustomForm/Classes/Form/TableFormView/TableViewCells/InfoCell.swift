//
//  InfoCell.swift
//  CommonLRF
//
//  Created by mind-288 on 3/5/21.
//

import UIKit

final class InfoCell: UITableViewCell {
    
    @IBOutlet weak private var vwLine: UIView!
    @IBOutlet weak private var lblPlaceHolder: UILabel!
    @IBOutlet weak private var btnSelection: UIButton!
    @IBOutlet weak private var btnPassword: UIButton!
    @IBOutlet weak private var txtField: UITextField!
    
    var isValidate: Bool?
    var plcHolder = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
    func configureCell(data: FormModel, pickerData: [String]) {
        
        formType = data.txtFieldType ?? .normal
        plcHolder = data.placeHolder ?? ""
        btnPassword.isHidden = true
        btnSelection.isHidden = true
        txtField.placeholder = data.placeHolder2
        txtField.keyboardType = data.keyboardType ?? .default
        txtField.isSecureTextEntry = data.isSecure ?? false
        txtField.inputView = nil
        //txtField.setupLeftImageView(img: UIImage(named: data.leftImgView ?? ""))
        
        if data.isValid ?? true {
            
            txtField.text = data.value
            lblPlaceHolder.text = data.placeHolder
            lblPlaceHolder.textColor = data.placeHolderColor
            
        } else {
            
            if txtField.keyboardType == .emailAddress {
                
                txtField.text = ""
                self.lblPlaceHolder.text = "Please Enter Valid Email*"
                self.lblPlaceHolder.textColor = UIColor.red
                
            } else {
                self.lblPlaceHolder.text = "Please Enter \(plcHolder)"
                self.lblPlaceHolder.textColor = UIColor.red
            }
        }
        
        switch data.txtFieldType {
        
        case .password:
            
            btnPassword.isHidden = false
            
        case .dob:
            
            if #available(iOS 13.4, *) {
                txtField.setDatePickerStyle()
            }
            
            txtField.setDatePickerMode(mode: .date)
            txtField.setMaximumDate(maxDate: Date())
            
            txtField.setDatePickerWithDateFormate(dateFormate: "dd/MM/yyyy", defaultDate: Date(), isPrefilledDate: true, selectedDateHandler: { date in
            })
            
        case .picker:
            
            txtField.setPickerData(arrPickerData: pickerData, pickerDataHandler: { [weak self]  (select, index, component) in
                guard let `self` = self else { return }
                self.txtField.text = select as? String
            })
            
        case .actionSheet, .selection(_):
            
            btnSelection.isHidden = false
            
        default:
            break
        }
    }
}

//MARK:- Action
//MARK:-
extension InfoCell {
    
    @IBAction func onTxtFieldValueChanged(_ sender: UITextField) {
        
        if txtField.text == "" && txtField.keyboardType != .emailAddress {
            
            lblPlaceHolder.text = "Please Enter \(plcHolder)"
            lblPlaceHolder.textColor = UIColor.red
            isValidate = false
            txtFieldValidateHandler?(isValidate ?? false)
            txtField.shake()
            
        } else {
            
            if txtField.keyboardType == .emailAddress {
                
                guard let txtEmail = txtField.text else { return }
                
                if txtEmail.isValidEmail == false {
                    
                    txtField.text = ""
                    lblPlaceHolder.text = "Please Enter Valid Email*"
                    lblPlaceHolder.textColor = UIColor.red
                    isValidate = false
                    txtFieldValidateHandler?(isValidate ?? false)
                    txtField.shake()
                    
                } else {
                    
                    lblPlaceHolder.text = plcHolder
                    lblPlaceHolder.textColor = UIColor.darkGray
                    if txtFieldValueHandler != nil {
                        txtFieldValueHandler?(txtField)
                    }
                    isValidate = true
                    txtFieldValidateHandler?(isValidate ?? true)
                }
                
            } else {
                
                isValidate = true
                lblPlaceHolder.text = plcHolder
                lblPlaceHolder.textColor = UIColor.darkGray
                if txtFieldValueHandler != nil {
                    txtFieldValueHandler?(txtField)
                }
                txtFieldValidateHandler?(isValidate ?? true)
            }
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

//MARK:- Check Valid Email Address
//MARK:-

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
