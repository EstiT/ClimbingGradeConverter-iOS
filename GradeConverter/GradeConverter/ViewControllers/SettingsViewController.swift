//
//  SettingsViewController.swift
//  GradeConverter
//
//  Created by Esti Tweg on 2018-05-17.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoText: UITextView!
    @IBOutlet weak var backgroundView: UIView!
  
    
    var schemes: [String] = ["Ewbank", "YDS",  "French", "UK", "UIAA", "Hueco", "Font"]
    var selectedScheme: Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
        if selectedScheme != nil{
            let indexPath = IndexPath(row: selectedScheme, section: 0)
            tableView.selectRow(at: indexPath, animated:false, scrollPosition:UITableView.ScrollPosition(rawValue: 0)!)
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            tableView.cellForRow(at: indexPath)?.tintColor = UIColor(red: 102/255, green: 11/255, blue: 19/255, alpha: 1.0)
        }
        
        infoButton.titleLabel?.textColor = UIColor(displayP3Red: 102/255, green: 11/255, blue: 19/255, alpha: 1.0)
        checkColorTheme()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if selectedScheme != nil{
            let indexPath = IndexPath(row: selectedScheme, section: 0)
            tableView.selectRow(at: indexPath, animated:false, scrollPosition:UITableView.ScrollPosition(rawValue: 0)!)
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            tableView.cellForRow(at: indexPath)?.tintColor = UIColor(red: 215/255, green: 20/255, blue: 20/255, alpha: 1.0)
        }
        checkColorTheme()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        checkColorTheme()
    }
    
    func checkColorTheme(){
        if #available(iOS 12.0, *) {
//            https://stackoverflow.com/questions/56457395/how-to-check-for-ios-dark-mode
            if self.traitCollection.userInterfaceStyle == .dark {
                backgroundView.backgroundColor = .black
            }
            else {
                backgroundView.backgroundColor = UIColor(red: CGFloat(255) / 255.0, green: CGFloat(240) / 255.0, blue: CGFloat(232) / 255.0, alpha: 1.0)
                
            }
        }
    }
    

    @IBAction func closeSettings(_ sender: Any) {
        (presentationController?.delegate as! RoutesViewController).viewDidAppear(false)
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func viewInfo(_ sender: Any) {
        infoText.setContentOffset(.zero, animated: false)
        UIView.transition(with: self.infoView, duration: 0.5, options: .transitionFlipFromTop, animations: {
            self.infoView.alpha = 1.0
            self.infoView.isHidden = false
        }, completion: nil)
    }
    
    @IBAction func closeInfo(_ sender: Any) {
        UIView.transition(with: self.infoView, duration: 0.5, options: .transitionFlipFromBottom, animations: {self.infoView.alpha = 0.0}, completion:{ (finished: Bool) -> () in
            self.infoView.isHidden = true
            
        })
        
       
      
    }
    
    
    
    // MARK: TABLE VIEW
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return schemes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        if UIDevice.current.userInterfaceIdiom == .pad {
            cell.label.font = UIFont.systemFont(ofSize: 25, weight: UIFont.Weight.regular)
        }
        cell.selectionStyle = .none
        cell.label.text = schemes[indexPath.row]
        cell.accessoryType = .none
        cell.backgroundColor = .clear
        
        if indexPath.row == selectedScheme {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.reloadData()
        selectedScheme = indexPath.row
        UserDefaults.standard.set(selectedScheme, forKey: "selectedScheme")
        tableView.selectRow(at: indexPath as IndexPath, animated:false, scrollPosition:UITableView.ScrollPosition(rawValue: 0)!)
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        tableView.cellForRow(at: indexPath)?.tintColor = UIColor(red: 215/255, green: 20/255, blue: 20/255, alpha: 1.0)
        tableView.cellForRow(at: indexPath)?.contentView.backgroundColor = .clear
        tableView.cellForRow(at: indexPath)?.backgroundColor = .clear
    }


}
