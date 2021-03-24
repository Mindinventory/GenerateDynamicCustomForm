//
//  TextViewCell.swift
//  CommonLRF
//
//  Created by mind-288 on 3/11/21.
//

import UIKit

final class TextViewCell: UITableViewCell {
    
    @IBOutlet weak private var vwAddressLine: UIView!
    @IBOutlet weak private var lblPlaceHolder: UILabel!
    @IBOutlet weak private var txtViewAddress: UITextView!
    
    var placeHolder2 = ""
    
    // Completion Handler For TextField's Value Changed
    var txtViewValueHandler: ((_ txtView: UITextView) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        txtViewAddress.delegate = self
    }
    
    deinit {}
}


//MARK:- Configure Cell
//MARK:-
extension TextViewCell {
    
    func configuareCell(info: FormModel, isEdit: Bool) {
        
        placeHolder2 = info.placeHolder2 ?? ""
        txtViewAddress.text = info.value
        lblPlaceHolder.text = info.placeHolder
        lblPlaceHolder.textColor = info.placeHolderColor
        txtViewAddress.placeholder = info.placeHolder2
        txtViewAddress.placeholderColor = .lightGray
        txtViewAddress.keyboardType = info.keyboardType ?? .default
    }
}

//MARK:- TextView Delegate
//MARK:-
extension TextViewCell: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        txtViewAddress.placeholder = ""
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txtViewAddress.text == "" {
            txtViewAddress.placeholder = placeHolder2
            txtViewAddress.placeholderColor = UIColor.lightGray
        }
        
        if txtViewValueHandler != nil {
            txtViewValueHandler?(textView)
        }
    }
}
