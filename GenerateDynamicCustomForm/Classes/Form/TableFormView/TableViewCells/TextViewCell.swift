//
//  TextViewCell.swift
//  CommonLRF
//
//  Created by mind-288 on 3/11/21.
//

import UIKit

final class TextViewCell: UITableViewCell {
    
    @IBOutlet weak var imgAddress: UIImageView!
    @IBOutlet weak private var txtViewAddress: UITextView!
    
    // Completion Handler For TextField's Value Changed
    var txtViewValueHandler: ((_ txtView: UITextView) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        txtViewAddress.delegate = self
    }
    
    deinit {
        print("TextViewCell is deinitialized")
    }
}


//MARK:- Configure Cell
//MARK:-
extension TextViewCell {
    
    func configuareCell(info: FormModel, isEdit: Bool) {
        
        txtViewAddress.text = info.value
        txtViewAddress.placeholder = info.placeHolder
        txtViewAddress.placeholderColor = info.placeHolderColor
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
            txtViewAddress.placeholder = "Enter Address"
            txtViewAddress.placeholderColor = UIColor.white.withAlphaComponent(0.6)
        }
        if txtViewValueHandler != nil {
            txtViewValueHandler?(textView)
        }
    }
}
