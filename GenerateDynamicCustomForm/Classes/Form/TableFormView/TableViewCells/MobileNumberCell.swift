//
//  MobileNumberCell.swift
//  CommonLRF
//
//  Created by mind-288 on 3/8/21.
//

import UIKit

final class MobileNumberCell: UITableViewCell {
    
    @IBOutlet weak private var cnstWidthCode: NSLayoutConstraint!
    @IBOutlet weak private var txtCntryCode: UITextField!
    @IBOutlet weak private var txtMobNO: UITextField!
    
    // Completion Handler For TextField's Value Changed
    var CntryCodeHandler: ((_ txtField: UITextField) -> Void)?
    var txtMobNoHandler: ((_ txtField: UITextField) -> Void)?
    var txtMobNoValidateHandler: ((_ isValid: Bool) -> Void)?
    
    var cntryCode: String?
    var isValidate: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        txtMobNO.delegate = self
    }
    
    deinit {
        print("MobileNumberCell is deinitialized")
    }
}

//MARK:- Configure Cell
//MARK:-
extension MobileNumberCell {
    
    func configureCell(data: FormModel, code: [String], flag: Bool, isValid: Bool) {
        
        if isValid {
            
            txtMobNO.layer.borderColor = UIColor.init(red: 235/255, green: 231/255, blue: 186/255, alpha: 1.0).cgColor
            txtMobNO.placeholder = data.placeHolder
            txtMobNO.placeholderColor = data.placeHolderColor
            
        } else {
            
            txtMobNO.layer.borderColor = UIColor.red.cgColor
            txtMobNO.placeholder = "Please Enter Value"
            txtMobNO.placeholderColor = UIColor.white.withAlphaComponent(0.6)
        }
        
        txtMobNO.text = data.value
        txtCntryCode.text = cntryCode ?? "+91"
        txtMobNO.placeholder = data.placeHolder
        txtMobNO.keyboardType = data.keyboardType ?? .default
        txtCntryCode.setPickerData(arrPickerData: code, pickerDataHandler: { (select, index, component) in
        })
        
        if flag == true {
            
            txtCntryCode.textAlignment = .right
            cnstWidthCode.constant = 86
            txtCntryCode.setupLeftImageView(img: UIImage(named: "ic_india"))
        }
    }
}

//MARK:- UITextFieldDelegate
//MARK:-
extension MobileNumberCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if txtMobNO.text == "" {
            
            txtMobNO.layer.borderColor = UIColor.red.cgColor
            txtMobNO.placeholder = "Please Enter Value"
            txtMobNO.placeholderColor = UIColor.white.withAlphaComponent(0.6)
            isValidate = false
            txtMobNoValidateHandler?(isValidate ?? false)
            txtMobNO.shake()
            
        } else {
            
            txtMobNO.layer.borderColor = UIColor.init(red: 235/255, green: 231/255, blue: 186/255, alpha: 1.0).cgColor
            isValidate = true
            txtMobNoValidateHandler?(isValidate ?? true)
        }
    }
}

//MARK:- Action
//MARK:-
extension MobileNumberCell {
    
    @IBAction func onMobNoValueChanged(_ sender: UITextField) {
        
        if txtMobNoHandler != nil {
            txtMobNoHandler?(txtMobNO)
        }
    }
    
    @IBAction func onCntryCodeValueChanged(_ sender: UITextField) {
        
        if CntryCodeHandler != nil {
            CntryCodeHandler?(txtCntryCode)
        }
    }
}
