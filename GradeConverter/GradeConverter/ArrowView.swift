//
//  ArrowView.swift
//  GradeConverter
//
//  Created by Esti Tweg on 2019-06-30.
//  Copyright © 2019 Esti Tweg. All rights reserved.
//

import Foundation
import UIKit


class ArrowView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.beginPath()
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY/3))
        context.addLine(to: CGPoint(x: rect.maxX/2, y: rect.maxY/3.0))
        context.addLine(to: CGPoint(x: rect.maxX/2, y: rect.maxY*0.05))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY/2.0))
        context.addLine(to: CGPoint(x: rect.maxX/2, y: rect.maxY*0.95))
        context.addLine(to: CGPoint(x: rect.maxX/2, y: rect.maxY * 2/3))
        context.addLine(to: CGPoint(x: (rect.minX), y: rect.maxY * 2/3))
        context.closePath()
        
        context.setFillColor(red: 179/255, green: 20/255, blue: 33/255, alpha: 1.0)
        context.fillPath()
    }
}
