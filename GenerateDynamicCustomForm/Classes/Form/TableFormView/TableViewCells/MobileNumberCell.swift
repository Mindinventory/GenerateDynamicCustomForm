//
//  MobileNumberCell.swift
//  CommonLRF
//
//  Created by mind-288 on 3/8/21.
//

import UIKit

final class MobileNumberCell: UITableViewCell {
    
    @IBOutlet weak private var vwMobNoLine: UIView!
    @IBOutlet weak private var vwcntryLine: UIView!
    @IBOutlet weak private var lblPlaceHolder: UILabel!
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
        
    }
    
    deinit {
        print("MobileNumberCell is deinitialized")
    }
}

//MARK:- Configure Cell
//MARK:-
extension MobileNumberCell {
    
    func configureCell(data: FormModel, code: [String], flag: Bool) {
        
        if data.isValid ?? true {
            lblPlaceHolder.text = data.placeHolder
            lblPlaceHolder.textColor = data.placeHolderColor
            
        } else {
            lblPlaceHolder.text = "Please Enter Mobile Number *"
            lblPlaceHolder.textColor = UIColor.red
        }
        
        txtMobNO.placeholder = data.placeHolder2
        txtMobNO.text = data.value
        txtCntryCode.text = cntryCode ?? "+91"
        txtMobNO.keyboardType = data.keyboardType ?? .default
        
        txtCntryCode.setPickerData(arrPickerData: code, pickerDataHandler: { (select, index, component) in
        })
        
        if flag == true {
            
            txtCntryCode.textAlignment = .right
            txtCntryCode.setupLeftImageView(img: UIImage(named: "ic_india"))
        }
    }
}

//MARK:- Action
//MARK:-
extension MobileNumberCell {
    
    @IBAction func onMobNoValueChanged(_ sender: UITextField) {
        
        if txtMobNO.text == "" {
            
            lblPlaceHolder.text = "Please Enter Mobile Number *"
            lblPlaceHolder.textColor = UIColor.red
            isValidate = false
            txtMobNoValidateHandler?(isValidate ?? false)
            txtMobNO.shake()
            
        } else if txtMobNO.text?.count != 10 {
            
            lblPlaceHolder.text = "Please Enter Valid Mobile Number *"
            lblPlaceHolder.textColor = UIColor.red
            isValidate = false
            txtMobNoValidateHandler?(isValidate ?? false)
            txtMobNO.shake()
            
        } else {
            
            isValidate = true
            lblPlaceHolder.text = placeHolderMobNo
            lblPlaceHolder.textColor = UIColor.darkGray
            
            if txtMobNoHandler != nil {
                txtMobNoHandler?(txtMobNO)
            }
            
            txtMobNoValidateHandler?(isValidate ?? true)
        }
    }
    
    @IBAction func onCntryCodeValueChanged(_ sender: UITextField) {
        
        if CntryCodeHandler != nil {
            CntryCodeHandler?(txtCntryCode)
        }
    }
}
