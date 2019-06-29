//
//  TriangleView.swift
//  GradeConverter
//
//  Created by Esti Tweg on 2019-06-28.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//  https://stackoverflow.com/questions/30650343/triangle-uiview-swift

import Foundation
import UIKit

class TriangleView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.maxY))
        context.closePath()
        
        context.setFillColor(red: 215/255, green: 20/255, blue: 20/255, alpha: 1.0)
        context.fillPath()
    }
}
