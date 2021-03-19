//
//  Model.swift
//  CommonLRF
//
//  Created by mind-288 on 3/4/21.
//

import UIKit

//MARK:- Model Form
//MARK:-

enum FormType {
    
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
    
    var formType: FormType
    var txtFieldType: TextFieldType?
    var value: String?
    var placeHolder: String?
    var placeHolderColor: UIColor?
    var leftImgView: String?
    var rightImgView: String?
    var isEnabled: Bool?
    var isSecure: Bool?
    var keyboardType: UIKeyboardType?
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

struct TextViewModel {
    
    var placeHolder: String
    var placeHolderColor: UIColor?
    var txt: String?
    var isEnabled: Bool?
    var keyboardType: UIKeyboardType?
}

struct MultiPhotoModel {
    
    var images: [UIImage]?
}

//MARK:- PlaceHolder Constants
//MARK:-
let placeHolderName = "Enter Name"
let placeHolderEmail = "Enter Email Address"
let placeHolderPassword = "Enter Password"
let placeHolderMobNo = "Enter Mobile Number"
let placeHolderDob = "Select Birth Date DD/MM/YYYY"
let placeHolderDept = "Select Department"
let placeHolderGender = "Select Gender"
let placeHolderAddress = "Enter Address"
let placeHolderHobbies = "Select Hobbies"
let placeHolderCountry = "Select Country"
