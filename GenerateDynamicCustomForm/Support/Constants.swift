//
//  ApplicationConstants.swift
// 
//
//  Created by mac-0006 on 11/04/19.
//  Copyright © 2019 mac-0006. All rights reserved.
//

import UIKit

let CScreenWidth = UIScreen.main.bounds.width
let CSharedApplication = UIApplication.shared
let appDelegate = CSharedApplication.delegate as! AppDelegate
let CGCDMainThread = DispatchQueue.main
let CMainStoryboard = UIStoryboard(name: "Main", bundle: nil)


func print(_ item: @autoclosure () -> Any, separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    //Swift.print(item(), separator: separator, terminator: terminator)
    #endif
}

