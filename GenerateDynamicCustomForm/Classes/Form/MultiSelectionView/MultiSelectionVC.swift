//
//  MultiSelectionVC.swift
//  CommonLRF
//
//  Created by mind-288 on 3/12/21.
//

import UIKit

final class MultiSelectionVC: UIViewController {
    
    @IBOutlet weak private var btnDone: UIButton!
    @IBOutlet weak private var vwBackground: UIView!
    @IBOutlet weak private var tblMultiSelection: TblMultiSelection!
    
    private var isMultipleSelection = false
    private var country = ""
    private var hobbies = [String]()
    
    static var hobbiesDataHandler: ((_ hobbiesdata: [String]) -> Void)?
    static var countryDataHandler: ((_ countrydata: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    deinit {
        print("MultiSelectionVC is deinitialized")
    }
}

//MARK:- Initialize
//MARK:-
extension MultiSelectionVC {
    
    private func initialize() {
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        btnDone.shadow(color: .black, shadowOffset: CGSize(width: 5.0, height: 5.0), shadowRadius: 10.0, shadowOpacity: 0.5)
        tblMultiSelection.hobbies = ["Movies", "Cricket", "Music", "Food", "Dance", "Game", "Travel"]
        tblMultiSelection.countries = ["India", "Other"]
        tblMultiSelection.isMultipleSelection = isMultipleSelection
        
        tblMultiSelection.countryDataHandler = { [weak self] value in
            
            guard let `self` = self else { return }
            self.country = value
        }
        
        tblMultiSelection.hobbiesDataHandler = { [weak self] value in
            
            guard let `self` = self else { return }
            self.hobbies = value
        }
    }
    
    static func showPopup(parentVC: UIViewController, isMultiple: Bool) {
        
        if let popUPMutliSelection = CMainStoryboard.instantiateViewController(withIdentifier: MultiSelectionVC.storyboardID) as? MultiSelectionVC {
            
            popUPMutliSelection.isMultipleSelection = isMultiple
            popUPMutliSelection.modalPresentationStyle = .custom
            popUPMutliSelection.modalTransitionStyle = .crossDissolve
            parentVC.present(popUPMutliSelection, animated: true)
        }
    }
}

//MARK:- Action
//MARK:-
extension MultiSelectionVC {
    
    @IBAction func onDone(_ sender: UIButton) {
        
        tblMultiSelection.getMultiSelectedData()
        
        if isMultipleSelection {
            MultiSelectionVC.hobbiesDataHandler?(hobbies)
        } else {
            MultiSelectionVC.countryDataHandler?(country)
        }
        self.dismiss(animated: true, completion: nil)
    }
}
