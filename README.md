# GenerateDynamicCustomForm

<a href="https://docs.swift.org/swift-book/" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/swift-5.0-yellowgreen">
</a>
<a href="#" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/platform-iOS-red">
</a>
<a href="https://github.com/ashishpatelmi/GenerateDynamicCustomForm/blob/main/LICENSE" style="pointer-events: stroke;" target="_blank">
<img src="https://img.shields.io/badge/licence-MIT.-orange">
</a>

You can generate a dynamic form view in a few minutes for signup, add a record. Creating a form is very easy.

![video](/Media/form.gif)

## Table of content :-

- [Description](#description)
- [Features](#features)
- [Usage](#usage)
- [By Apple](#by-apple)
- [License](#license)
    
## Description

In this form there are various textFields like Username, email, Password, etc. it has validations also, if validation passes then user can submit form. If any validation doesn't pass then we are showing the validation using the label. The changes are reactive to the textField changes. User can also edit the form and can view changes.

## Features

- TextField with different types like email, password, mobile number, etc.
- Profile Photo and Banner image selection.
- TextView for Address field.
- DatePicker for Date of Birth.
- Picker for department selection.
- ActionSheet for Gender selection.
- PopUpView for selecting multiple/single values.
- Multiple photos selection.
- Switch control for toggling values.
- Checkbox for accepting terms and conditions.
- Submit button for saving data.
- After Successful saving of data one can check entered data and also edit the data.

## Usage

- First create two enums one for Form Control and another one for TextField Type.

1. In ControlType enum you can add cases for different controls like,

    - TextField
    - ProfileImage
    - Switch
    - TextView
    - CheckBox

```Swift

enum ControlType {
    
    case checkBox
    case textField
    case profileImage
    case switchType
    case textView
    case multiPhoto
}

```

Based on that you can create different cells in TableView

2. In TextField Type enum you can add cases for different TextField types like,
    
    - Normal Textfield
    - Password
    - Picker, date picker, etc.

```Swift

enum TextFieldType: Equatable {
    
    case normal
    case password
    case dob
    case picker
    case actionSheet
    case selection(Bool?) // Pass true or false for Allowing multiple Selection
    case mobileNumber(Bool?) //Pass true or false for Country Flag
}

```

Based on that you can create different textfield with different keyboard type and inputView.

3. After that create a Structure with two enums that we have created early and add additional properties based on your requirement like,

    - TextField value
    - Placeholder
    - Placeholder color
    - Keyboard type
    - Secure text entry, etc.

```Swift

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

```

Based on this Structure you will be able to create a Model which will be used by Tableview. Now just assign data into Model according to your needs. After this you have to just pass enum case in cellForRow and accordingly pass model data into cell to generate Form.

## By Apple 

- Xcode 12
- iOS 11+

## LICENSE!

GenerateDynamicCustomForm is [MIT-licensed](/LICENSE).
