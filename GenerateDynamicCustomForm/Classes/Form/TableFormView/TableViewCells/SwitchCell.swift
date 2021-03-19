//
//  SwitchCell.swift
//  CommonLRF
//
//  Created by mind-288 on 3/11/21.
//

import UIKit

final class SwitchCell: UITableViewCell {
    
    @IBOutlet weak private var swtch: UISwitch!
    @IBOutlet weak private var lblSwitch: UILabel!
    
    var switchHandler: ((_ onOff: Bool) -> Void)?
    
    deinit {
        print("SwitchCell is deinitialized")
    }
}

//MARK:- Action
//MARK:-
extension SwitchCell {
    
    func configureCell(value: Bool) {
        
        if value {
            lblSwitch.text = "Notification : On"
            swtch.isSelected = false
            swtch.setOn(true, animated: true)
        } else {
            lblSwitch.text = "Notification : Off"
            swtch.isSelected = true
            swtch.setOn(false, animated: true)
        }
    }
}

//MARK:- Action
//MARK:-
extension SwitchCell {
    
    @IBAction func onChanged(_ sender: UISwitch) {
        
        if sender.isSelected {
            
            sender.isSelected.toggle()
            lblSwitch.text = "Notification : On"
            if switchHandler != nil {
                switchHandler?(true)
            }
            
        } else {
            
            sender.isSelected.toggle()
            lblSwitch.text = "Notification : Off"
            if switchHandler != nil {
                switchHandler?(false)
            }
        }
    }
}
