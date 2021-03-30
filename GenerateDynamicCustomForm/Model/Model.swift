//
//  Model.swift
//  CommonLRF
//
//  Created by mind-288 on 3/4/21.
//

import UIKit

//MARK:- Model Form
//MARK:-

enum ControlType {
    
    case checkBox
    case textField
    case profileImage
    case switchType
    case textView
    case multiPhoto
}

enum TextFieldType: Equatable {
    
    case normal
    case password
    case dob
    case picker
    case actionSheet
    case selection(Bool?) // Pass true or false for Allowing multiple Selection
    case mobileNumber(Bool?) //Pass true or false for Country Flag
}

struct FormModel {
    
    var controlType: ControlType
    var txtFieldType: TextFieldType?
    var value: String?
    var placeHolder: String?
    var placeHolder2: String?
    var placeHolderColor: UIColor?
    var leftImgView: String?
    var rightImgView: String?
    var isEnabled: Bool?
    var isSecure: Bool?
    var keyboardType: UIKeyboardType?
    var isValid: Bool?
}

struct ProfileImageModel {
    
    var userImg: UIImage?
    var bannerImg: UIImage?
}

struct CheckBoxModel {
    var isChecked: Bool?
}

struct SwitchModel {
    var isOn: Bool?
}

struct MultiPhotoModel {
    
    var images: [UIImage]?
}

//MARK:- PlaceHolder Constants
//MARK:-
let placeHolderName = "Name*"
let placeHolderEmail = "Email Address*"
let placeHolderPassword = "Password*"
let placeHolderMobNo = "Mobile Number*"
let placeHolderDob = "Birth Date"
let placeHolderDept = "Department"
let placeHolderGender = "Gender"
let placeHolderAddress = "Address"
let placeHolderHobbies = "Hobbies"
let placeHolderCountry = "Country"
