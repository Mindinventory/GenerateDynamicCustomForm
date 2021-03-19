//
//  ListCell.swift
//  CommonLRF
//
//  Created by mind-288 on 3/9/21.
//

import UIKit

final class ListCell: UITableViewCell {

    @IBOutlet weak private var lblUserList: UILabel!
}

//MARK:- Configure Cell
//MARK:-
extension ListCell {
    
    func configureCell(data: String?) {
        
        lblUserList.text = data
    }
}
