//
//  TableCell.swift
//  GradeConverter
//
//  Created by Esti Tweg on 2018-05-16.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import Foundation
import UIKit

class TableCell : UITableViewCell{
    
    @IBOutlet weak var label: UILabel!
  
    
    var name: String{
        didSet{
            label.text = name;
        }
    }
    
    override var isSelected: Bool{
        didSet{
           
            
        }
    }
    
    
    required init?(coder aDecoder: NSCoder){
        self.name = "";
        super.init(coder: aDecoder);
    }

    
}
