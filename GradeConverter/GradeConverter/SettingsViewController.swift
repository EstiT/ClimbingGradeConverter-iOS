//
//  SettingsViewController.swift
//  GradeConverter
//
//  Created by Esti Tweg on 2018-05-17.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var closeImageView: UIImageView!
    @IBOutlet weak var schemePickerView: UIPickerView!
    
    var schemes: [String] = ["French", "UK",  "Australia", "UIAA", "North America", "Hueco", "UK", "Font"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.closeTapped))
        singleTap.numberOfTapsRequired = 1
        closeImageView.addGestureRecognizer(singleTap)
        closeImageView.isUserInteractionEnabled = true
        
        schemePickerView.dataSource = self
        schemePickerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func closeTapped(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //- PICKERVIEW
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return schemes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return schemes[row]
    }

}
