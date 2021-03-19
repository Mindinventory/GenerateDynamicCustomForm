//
//  SelectionCell.swift
//  CommonLRF
//
//  Created by mind-288 on 3/12/21.
//

import UIKit

final class SelectionCell: UITableViewCell {
    
    @IBOutlet weak private var lblSelection: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

//MARK:- ConfigureCell
//MARK:-
extension SelectionCell {
    
    func configureCell(data: String, isMulti: Bool, index: Int) {
        
        lblSelection.text = data
    }
}
