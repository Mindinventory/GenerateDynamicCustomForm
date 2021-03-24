//
//  ExtensionUITextField.swift
//
//  Created by mac-0005 on 06/01/2020.
//  Copyright © 2020. All rights reserved.
//

import UIKit

// MARK: - TextField's placeholder Color. -

extension UITextField {
    
    /// Placeholder Color of UITextField , as it is @IBInspectable so you can directlly set placeholder color of UITextField From Interface Builder , No need to write any number of Lines.
    @IBInspectable var placeholderColor: UIColor? {
        get  {
            return self.placeholderColor
        } set {
            if let newValue = newValue {
                
                self.attributedPlaceholder = NSAttributedString(
                    string: self.placeholder ?? "",
                    attributes: [.foregroundColor:newValue]
                )
            }
        }
    }
}

typealias selectedDateHandler = ((Date) -> ())

// MARK: - DatePicker as TextField's inputView. -
extension UITextField {
    
    /// This Private Structure is used to create all AssociatedObjectKey which will be used within this extension.
    fileprivate struct AssociatedObjectKey {
        
        static var txtFieldDatePicker = "txtFieldDatePicker"
        static var datePickerDateFormatter = "datePickerDateFormatter"
        static var selectedDateHandler = "selectedDateHandler"
        static var defaultDate = "defaultDate"
        static var isPrefilledDate = "isPrefilledDate"
    }
    
    /// A Computed Property of UIDatePicker , If its already in memory then return it OR not then create new one and store it in memory reference.
    fileprivate var txtFieldDatePicker: UIDatePicker? {
        
        guard let txtFieldDatePicker = objc_getAssociatedObject(
            self,
            &AssociatedObjectKey.txtFieldDatePicker) as? UIDatePicker else {
                return self.addDatePicker()
        }
        
        return txtFieldDatePicker
    }
    
    /// A Private method used to create a UIDatePicker and store it in a memory reference.
    ///
    /// - Returns: return a newly created UIDatePicker.
    private func addDatePicker() -> UIDatePicker {
        
        let txtFieldDatePicker = UIDatePicker()
        self.inputView = txtFieldDatePicker
        
        txtFieldDatePicker.addTarget(
            self,
            action: #selector(self.handleDateSelection(sender:)),
            for: .valueChanged
        )
        
        objc_setAssociatedObject(
            self,
            &AssociatedObjectKey.txtFieldDatePicker,
            txtFieldDatePicker,
            .OBJC_ASSOCIATION_RETAIN
        )
        
        self.inputAccessoryView = self.addToolBar()
        self.tintColor = .clear
        
        return txtFieldDatePicker
    }
    
    /// A Computed Property of DateFormatter , If its already in memory then return it OR not then create new one and store it in memory reference.
    fileprivate var datePickerDateFormatter: DateFormatter? {
        
        guard let datePickerDateFormatter = objc_getAssociatedObject(
            self,
            &AssociatedObjectKey.datePickerDateFormatter) as? DateFormatter else {
                return self.addDatePickerDateFormatter()
        }
        
        return datePickerDateFormatter
    }
    
    /// A Private methos used to create a DateFormatter and store it in a memory reference.
    ///
    /// - Returns: return a newly created DateFormatter.
    private func addDatePickerDateFormatter() -> DateFormatter {
        
        let datePickerDateFormatter = DateFormatter()
        
        objc_setAssociatedObject(
            self,
            &AssociatedObjectKey.datePickerDateFormatter,
            datePickerDateFormatter,
            .OBJC_ASSOCIATION_RETAIN
        )
        
        return datePickerDateFormatter
    }
    
    /// A Private method used to handle the date selection event everytime when value changes from UIDatePicker.
    ///
    /// - Parameter sender: UIDatePicker - helps to trach the selected date from UIDatePicker
    @objc private func handleDateSelection(sender: UIDatePicker) {
        
        self.text = self.datePickerDateFormatter?.string(from: sender.date)
        
        objc_setAssociatedObject(
            self,
            &AssociatedObjectKey.defaultDate,
            sender.date,
            .OBJC_ASSOCIATION_RETAIN
        )
        
        if let selectedDateHandler = objc_getAssociatedObject(self, &AssociatedObjectKey.selectedDateHandler) as? selectedDateHandler {
            selectedDateHandler(sender.date)
        }
    }
    
    func setDatePickerMode(mode: UIDatePicker.Mode) {
        self.txtFieldDatePicker?.datePickerMode = mode
    }
    
    func setMaximumDate(maxDate: Date) {
        self.txtFieldDatePicker?.maximumDate = maxDate
    }
    
    @available(iOS 13.4, *)
    func setDatePickerStyle() {
        self.txtFieldDatePicker?.preferredDatePickerStyle = .wheels
    }
    
    
    func setDatePickerWithDateFormate(dateFormate: String, defaultDate: Date?, isPrefilledDate: Bool, selectedDateHandler: @escaping selectedDateHandler) {
        
        self.inputView = self.txtFieldDatePicker
        
        self.setDateFormate(dateFormat: dateFormate)
        
        // Storting the handler.
        objc_setAssociatedObject(
            self,
            &AssociatedObjectKey.selectedDateHandler,
            selectedDateHandler,
            .OBJC_ASSOCIATION_RETAIN
        )
        
        // Storting the default date.
        objc_setAssociatedObject(
            self,
            &AssociatedObjectKey.defaultDate,
            defaultDate,
            .OBJC_ASSOCIATION_RETAIN
        )
        
        // Storting the Prefilled date boolean.
        objc_setAssociatedObject(
            self,
            &AssociatedObjectKey.isPrefilledDate,
            isPrefilledDate,
            .OBJC_ASSOCIATION_RETAIN
        )
        
        self.delegate = self
    }
    
    /// A Private method is used to set the dateFormat of UIDatePicker.
    ///
    /// - Parameter dateFormat: A String Value used to set the dateFormatof UIDatePicker.
    private func setDateFormate(dateFormat: String) {
        self.datePickerDateFormatter?.dateFormat = dateFormat
    }
}

// MARK: - Tool bar -
extension UITextField {
    
    /// A fileprivate method is used to add a UIToolbar above UIDatePicker. This UIToolbar contain only one UIBarButtonItem(Done).
    ///
    /// - Returns: return newly created UIToolbar
    fileprivate func addToolBar() -> UIToolbar {
        
        let toolBar = UIToolbar(
            frame: CGRect(
                x: 0.0,
                y: 0.0,
                width: UIScreen.main.bounds.width,
                height: 44.0)
        )
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: self,
            action: nil
        )
        
        let btnDone = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(self.btnDoneTapped(sender:))
        )
        
        toolBar.setItems(
            [flexibleSpace, btnDone],
            animated: true
        )
        
        return toolBar
    }
    
    /// A Private method used to handle the touch event of button Done(A UIToolbar Button).
    ///
    /// - Parameter sender: UIBarButtonItem
    @objc private func btnDoneTapped(sender: UIBarButtonItem) {
        
        self.resignFirstResponder()
        
        guard let doneCompletionHandler = objc_getAssociatedObject(self, &AssociatedObjectKeyTwo.doneCompletionHandler) as? doneCompletionHandler else {
            return
        }
        
        doneCompletionHandler?()
    }
}

// MARK: - PickerView as TextField's inputView. -

typealias selectedPickerDataHandler = ((_ info: Any, _ row: Int, _ component: Int) -> ())
typealias doneCompletionHandler = (() -> ())?

extension UITextField {
    
    fileprivate struct AssociatedObjectKeyTwo {
        static var txtFieldPickerView = "txtFieldPickerView"
        static var selectedPickerDataHandler = "selectedPickerDataHandler"
        static var doneCompletionHandler = "doneCompletionHandler"
        static var arrPickerData = "arrPickerData"
        static var arrPickerCoreData = "arrPickerCoreData"
        static var data = "data"
        static var key = "key"
    }
    
    fileprivate var txtFieldPickerView: UIPickerView {
        
        guard let txtFieldPickerView = objc_getAssociatedObject(self, &AssociatedObjectKeyTwo.txtFieldPickerView) as? UIPickerView else {
            return self.addPickerView()
        }
        
        return txtFieldPickerView
    }
    
    private func addPickerView() -> UIPickerView {
        
        let txtFieldPickerView = UIPickerView()
        
        txtFieldPickerView.dataSource  = self
        txtFieldPickerView.delegate  = self
        
        self.inputView = txtFieldPickerView
        
        objc_setAssociatedObject(
            self,
            &AssociatedObjectKeyTwo.txtFieldPickerView,
            txtFieldPickerView,
            .OBJC_ASSOCIATION_RETAIN
        )
        
        self.inputAccessoryView = self.addToolBar()
        self.tintColor = .clear
        
        return txtFieldPickerView
    }
    
    fileprivate var arrPickerData: [Any] {
        get {
            
            let isCoreData = checkForCoreDataPicker()
            
            if isCoreData.isNSManagedObject == false,
                let arrPickerData = isCoreData.result as? [Any] {
                
                // Getting the direct array
                return arrPickerData
            }
            
            return []
        }
    }
    
    private func checkForCoreDataPicker() -> (isNSManagedObject: Bool, result: Any?) {
        
        if let arrPickerData = objc_getAssociatedObject(self, &AssociatedObjectKeyTwo.arrPickerData) as? [Any] {
            // It will return normal picker data
            return (false, arrPickerData)
            
        } else if let coreDataInfo = objc_getAssociatedObject(self, &AssociatedObjectKeyTwo.arrPickerCoreData) as? [String: Any] {
        
            // It will return NSManagedObject object
            return (true, coreDataInfo)
        }
        
        return (false, nil)
    }
    
    private func pickerDidSelectRow(didSelectRow row: Int, inComponent component: Int) {

        self.text = "\(arrPickerData[row])"
        
        guard let selectedPickerDataHandler = objc_getAssociatedObject(self, &AssociatedObjectKeyTwo.selectedPickerDataHandler) as? selectedPickerDataHandler else {
            return
        }
        
        selectedPickerDataHandler(
            self.text ?? "",
            row,
            component
        )
        return
    }
    
    func setPickerData(
        arrPickerData: [Any],
        doneCompletionHandler: doneCompletionHandler? = nil,
        pickerDataHandler: @escaping selectedPickerDataHandler
    ) {
        
        self.inputView = txtFieldPickerView
        
        objc_setAssociatedObject(
            self,
            &AssociatedObjectKeyTwo.arrPickerData,
            arrPickerData,
            .OBJC_ASSOCIATION_RETAIN
        )
        
        txtFieldPickerView.reloadAllComponents()
        
        objc_setAssociatedObject(
            self,
            &AssociatedObjectKeyTwo.selectedPickerDataHandler,
            pickerDataHandler,
            .OBJC_ASSOCIATION_RETAIN
        )
        
        // Store handler for DONE button click.
        if let doneHandler = doneCompletionHandler {
            objc_setAssociatedObject(
                self,
                &AssociatedObjectKeyTwo.doneCompletionHandler,
                doneHandler,
                .OBJC_ASSOCIATION_RETAIN
            )
        }
        
        self.delegate = self
    }
}

// MARK:- PickerView dataSource/delegate -
extension UITextField: UIPickerViewDataSource, UIPickerViewDelegate {
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
          return 1
      }
      
      public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
          return arrPickerData.count
      }
      
      public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
          return "\(arrPickerData[row])"
      }
      
      public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerDidSelectRow(didSelectRow: row, inComponent: component)
      }
}

// MARK:- TextField Delegate -
extension UITextField: UITextFieldDelegate {
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if let _ = self.inputView as? UIDatePicker {
            
            if let isPrefilledDate = objc_getAssociatedObject(self, &AssociatedObjectKey.isPrefilledDate) as? Bool {
                
                if isPrefilledDate {
                    
                    if let defaultDate = objc_getAssociatedObject(self, &AssociatedObjectKey.defaultDate) as? Date {
                        
                        self.txtFieldDatePicker?.date = defaultDate
                        
                        self.text = self.datePickerDateFormatter?.string(from: defaultDate)
                    }
                }
            }
            
        } else if let _ = self.inputView as? UIPickerView {
            
            guard arrPickerData.count > 0 else {
                return
            }
            
            if let index = arrPickerData.firstIndex(where: {($0 as? String) == textField.text}) {
                
                txtFieldPickerView.selectRow(
                    index,
                    inComponent: 0,
                    animated: false
                )
                
                pickerDidSelectRow(
                    didSelectRow: index,
                    inComponent: 0
                )
            } else {
                
                txtFieldPickerView.selectRow(
                    0,
                    inComponent: 0,
                    animated: false
                )
                
                pickerDidSelectRow(
                    didSelectRow: 0,
                    inComponent: 0
                )
            }
        }
    }
}

extension UITextField {
    
    func setupLeftImageView(img:UIImage?) {
        
        let leftImageView = UIImageView(image: img)
        leftImageView.contentMode = .scaleAspectFit
        
        let _leftView = UIView()
        _leftView.clipsToBounds = true
        _leftView.addSubview(leftImageView)
        
        leftImageView.center = _leftView.center
        _leftView.frame = CGRect(
            x: 0,
            y: 0,
            width: 40,
            height: 32
        )
        
        leftImageView.frame = CGRect(
            x: 5,
            y: 5,
            width: 20,
            height: 20
        )
        
        self.leftViewMode = .always
        self.leftView = _leftView
    }
    
    func shake() {
        
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.10
        animation.autoreverses = true
        
        animation.fromValue = NSValue(cgPoint: CGPoint(
            x: self.center.x - 10,
            y: self.center.y))
        
        animation.toValue = NSValue(cgPoint: CGPoint(
            x: self.center.x + 10,
            y: self.center.y))
        
        self.layer.add(
            animation,
            forKey: "position"
        )
    }
}
