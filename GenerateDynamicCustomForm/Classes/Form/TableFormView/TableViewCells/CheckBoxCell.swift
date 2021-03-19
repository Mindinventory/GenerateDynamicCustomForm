//
//  CheckBoxCell.swift
//  CommonLRF
//
//  Created by mind-288 on 3/5/21.
//

import UIKit

final class CheckBoxCell: UITableViewCell {
    
    @IBOutlet weak private var btnCheck: UIButton!
    
    var checkBoxCheckedHandler: ((_ checked: Bool) -> Void)?
    
    deinit {
        print("CheckBoxCell is deinitialized")
    }
}

//MARK:- Initialize
//MARK:-
extension CheckBoxCell {
    
    func configureCell(isChecked: Bool) {
        
        btnCheck.isSelected = isChecked
        btnCheck.setImage(UIImage(named: "ic_check"), for: .normal)
        
    }
}

//MARK:- Action
//MARK:-
extension CheckBoxCell {
    
    @IBAction private func onCheck(_ sender: UIButton) {
        
        if sender.isSelected {
            
            btnCheck.setImage(UIImage(named: "ic_uncheck"), for: .normal)
            sender.isSelected.toggle()
            if checkBoxCheckedHandler != nil {
                checkBoxCheckedHandler?(false)
            }
            
        } else {
            
            btnCheck.setImage(UIImage(named: "ic_check"), for: .normal)
            sender.isSelected.toggle()
            if checkBoxCheckedHandler != nil {
                checkBoxCheckedHandler?(true)
            }
        }
    }
}
