//
//  RoundedView.swift
//  GradeConverter
//
//  Created by Esti Tweg on 2019-07-10.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//

import Foundation
import UIKit

//https://stackoverflow.com/questions/46713603/round-corners-uiview-in-swift-4
@IBDesignable
class RoundedView: UIView {
    @IBInspectable var borderColor: UIColor = UIColor(displayP3Red: 227/255.0, green: 143/255.0, blue: 61/255.0, alpha: 1.0) {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 2.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 10.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
}
