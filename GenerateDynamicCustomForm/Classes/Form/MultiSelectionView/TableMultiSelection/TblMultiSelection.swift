//
//  TblMultiSelection.swift
//  CommonLRF
//
//  Created by mind-288 on 3/12/21.
//

import UIKit

final class TblMultiSelection: UITableView {
    
    var hobbies = [String]()
    var countries = [String]()
    var hobbiesData = [String]()
    var country = ""
    var isMultipleSelection = false
    
    private var selectedIndex = -1
    
    var hobbiesDataHandler: ((_ hobbiesdata: [String]) -> Void)?
    var countryDataHandler: ((_ countrydata: String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initialize()
    }
    
    deinit {
        print("TblMultiSelection is deinitialized")
    }
}

//MARK:- Initialize
//MARK:-
extension TblMultiSelection {
    
    private func initialize() {
        
        dataSource = self
        delegate = self
        register(SelectionCell.nib, forCellReuseIdentifier: SelectionCell.identifier)
    }
}

//MARK:- UITableView Datasource and Delegate
//MARK:-
extension TblMultiSelection: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        allowsMultipleSelection = isMultipleSelection
        return isMultipleSelection ? hobbies.count : countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let selectionCell = tableView.dequeueReusableCell(withIdentifier: SelectionCell.identifier) as? SelectionCell {
            
            if !isMultipleSelection {
                
                if indexPath.row == selectedIndex {
                    selectionCell.accessoryType = .checkmark
                } else {
                    selectionCell.accessoryType = .none
                }
                
            } else {
                
                if let _ = tableView.indexPathsForSelectedRows?.firstIndex(of: indexPath) {
                    selectionCell.accessoryType = .checkmark
                } else {
                    selectionCell.accessoryType = .none
                }
            }
            
            selectionCell.configureCell(data: isMultipleSelection ? hobbies[indexPath.row] : countries[indexPath.row], isMulti: isMultipleSelection, index: indexPath.row)
            
            return selectionCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = cellForRow(at: indexPath) else { return }
        
        cell.accessoryType = .checkmark
        
        if !isMultipleSelection {
            
            selectedIndex = indexPath.row
            let country = countries[selectedIndex]
            print(country)
            countryDataHandler?(country)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        guard let cell = cellForRow(at: indexPath) else { return }
        cell.accessoryType = .none
    }
}

//MARK:- Get Selected Hobbies
//MARK:-

extension TblMultiSelection {
    
    func getMultiSelectedData() {
        
        if isMultipleSelection {
            
            guard let selectedIndexPath = indexPathsForSelectedRows else { return }
            
            for indexpath in selectedIndexPath {
                hobbiesData.append(hobbies[indexpath.row])
            }
            hobbiesDataHandler?(hobbiesData)
        }
    }
}
