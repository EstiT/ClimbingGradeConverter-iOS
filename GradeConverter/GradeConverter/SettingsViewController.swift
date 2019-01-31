//
//  SettingsViewController.swift
//  GradeConverter
//
//  Created by Esti Tweg on 2018-05-17.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var schemePickerView: UIPickerView!
    
    var schemes: [String] = ["French", "UK",  "Australia", "UIAA", "North America", "Hueco", "UK-Bouldering", "Font"]
    var selectedScheme: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        schemePickerView.dataSource = self
        schemePickerView.delegate = self
        
        if selectedScheme != nil{
            schemePickerView.selectRow(selectedScheme, inComponent:0, animated:false)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if selectedScheme != nil{
            schemePickerView.selectRow(selectedScheme, inComponent:0, animated:false)
        }
    }

    @IBAction func closeSettings(_ sender: Any) {
        if let presenter = presentingViewController as? RoutesViewController {
            presenter.selectedScheme = self.selectedScheme
        }
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedScheme = row
        UserDefaults.standard.set(selectedScheme, forKey: "selectedScheme")
    }

}
