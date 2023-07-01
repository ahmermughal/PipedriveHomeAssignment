//
//  ScreenSize.swift
//  PipedriveTakeHome
//
//  Created by Ahmer Akhter on 01/07/2023.
//

import UIKit


enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}

