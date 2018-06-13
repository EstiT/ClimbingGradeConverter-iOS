//
//  FirstViewController.swift
//  GradeConverter
//
//  Created by Esti Tweg on 2018-04-04.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import UIKit

class RoutesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    var schemes: [String] = ["French", "UK",  "Australia", "UIAA", "North America", "Hueco", "UK-Bouldering", "Font"]
    
    var grades: [[String]] = [
        ["1-2", "2-3", "4", "4+", "5a", "5b", "6a", "6a+", "6b", "6b+", "6c", "6c+", "7a", "7a+", "7b", "7b+", "7c", "7c+", "8a", "8a+", "8b", "8b+", "8c", "8c+", "9a","9a+", "9b", "9b+"],
        ["HVD", "MS", "S", "VS", "HVS", "", "E1 5b", "E2 5c", "", "E3 5c", "", "E4 6a", "", "E5 6b", "", "E6 6b", "", "", "E7 6c", "", "E8 7a", "", "E9 7b", "", "E10 7c", "E11", "E12", "E13"],
        ["8-9", "10-12", "13-14", "15", "16", "17", "18", "19", "20", "21", "21/22", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36","37","38"],
        ["I-II", "III", "IV", "V-", "V", "V+", "VI+", "VI+/VII-", "VII", "VII+", "VII+/VIII-", "VIII-", "VIII", "VIII/VIII+", "VIII+", "IX-", "IX", "IX/IX+", "IX+", "X-", "X", "X/X+", "X+", "XI-", "XI", "XI+","XII-","XII"],
        ["5.2-5.3", "5.4-5.5", "5.6", "5.7", "5.8", "5.9", "5.10a", "5.10b", "5.10c", "5.10d", "5.11a", "5.11b", "5.11c/d", "5.12a", "5.12b", "5.12c", "5.12d", "5.13a", "5.13b", "5.13c", "5.13d", "5.14a", "5.14b", "5.14c", "5.14d", "5.15a", "5.15b", "5.15c"],
        ["","","","","","V0", "","V0+", "V1", "", "V2", "V3", "", "V4", "V5", "V6", "", "V7", "V8", "V9", "V10", "V11", "V12", "V12/V13","V13", "V14", "V15", "V16"],
        ["","","","","","B1", "","B2", "B3", "", "B4", "", "B5-6", "", "", "B7", "", "B8", "", "B9", "", "B10", "", "B12", "", "","", ""],
        ["","","","","","4", "","4+", "5", "", "6a", "6a+", "", "6b/c", "6c", "6c+", "7a", "7a+", "7b", "7c", "", "7c+", "8a", "8a+", "8b",  "8b+", "8c", "8c+"]]
    
    var gradesWOEmptys: [[String]] = [
        ["1-2", "2-3", "4", "4+", "5a", "5b", "6a", "6a+", "6b", "6b+", "6c", "6c+", "7a", "7a+", "7b", "7b+", "7c", "7c+", "8a", "8a+", "8b", "8b+", "8c", "8c+", "9a","9a+", "9b", "9b+"],
        ["HVD", "MS", "S", "VS", "HVS", "E1 5b", "E2 5c", "E3 5c", "E4 6a", "E5 6b", "E6 6b", "E7 6c", "E8 7a", "E9 7b",  "E10 7c", "E11", "E12", "E13"],
        ["8-9", "10-12", "13-14", "15", "16", "17", "18", "19", "20", "21", "21/22", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36","37", "38"],
        ["I-II", "III", "IV", "V-", "V", "V+", "VI+", "VI+/VII-", "VII", "VII+", "VII+/VIII-", "VIII-", "VIII", "VIII/VIII+", "VIII+", "IX-", "IX", "IX/IX+", "IX+", "X-", "X", "X/X+", "X+", "XI-", "XI","XI+","XII-","XII"],
        ["5.2-5.3", "5.4-5.5", "5.6", "5.7", "5.8", "5.9", "5.10a", "5.10b", "5.10c", "5.10d", "5.11a", "5.11b", "5.11c/d", "5.12a", "5.12b", "5.12c", "5.12d", "5.13a", "5.13b", "5.13c", "5.13d", "5.14a", "5.14b", "5.14c", "5.14d", "5.15a", "5.15b", "5.15c"],
        ["V0","V0+", "V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9", "V10", "V11", "V12", "V12/V13", "V13",  "V14", "V15", "V16"],
        ["B1", "B2", "B3", "B4", "B5-6", "B7", "B8", "B9", "B10", "B12"],
        ["4","4+", "5", "6a", "6a+", "6b/c", "6c", "6c+", "7a", "7a+", "7b", "7c", "7c+", "8a", "8a+", "8b",  "8b+", "8c", "8c+"]]
    

    @IBOutlet weak var selectedGradesList: UICollectionView!
    
    @IBOutlet weak var schemeList: UITableView!
    @IBOutlet weak var gradesList: UITableView!
    
    @IBOutlet weak var schemeLabel: UILabel!
    @IBOutlet weak var settingsImageView: UIImageView!
    
    var selectedScheme = 0
    var selectedGrade = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //restore preferences
        selectedScheme = UserDefaults.standard.integer(forKey: "selectedScheme")
        
        selectedGrade = UserDefaults.standard.integer(forKey: "selectedGrade")
        selectedGradesList.allowsSelection = true
        selectedGradesList.dataSource = self
        selectedGradesList.delegate = self
        selectedGradesList.reloadData()

        schemeLabel.text = schemes[selectedScheme]
        
        schemeList.dataSource = self
        schemeList.delegate = self
        schemeList.reloadData()
        schemeList.tableFooterView = UIView(frame: .zero)
        
        gradesList.dataSource = self
        gradesList.delegate = self
        gradesList.reloadData()
        gradesList.tableFooterView = UIView(frame: .zero)
        
        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RoutesViewController.settingsTapped))
        singleTap.numberOfTapsRequired = 1
        settingsImageView.addGestureRecognizer(singleTap)
        settingsImageView.isUserInteractionEnabled = true
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateSelectedScheme()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // COLLECTION VIEW
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return gradesWOEmptys[selectedScheme].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GradeCell", for: indexPath) as! GradeCell
        cell.gradeName = gradesWOEmptys[selectedScheme][indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GradeCell", for: indexPath) as! GradeCell
        cell.gradeNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        selectedGrade = indexPath.row
        UserDefaults.standard.set(selectedGrade, forKey: "selectedGrade")
        gradesList.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GradeCell", for: indexPath) as! GradeCell
        cell.gradeNameLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)
    }
    
    
   // TABLE VIEW
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch section {
        case 0:
            return 5
        case 1:
            return 3
        default:
            return 8
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        if tableView == schemeList {//&& indexPath.row != selectedScheme
            if indexPath.section == 0{
                cell.label.text = schemes[indexPath.row]
            }
            else{
                if indexPath.row == 1 {
                    cell.label.text = "UK"
                }
                else{
                    cell.label.text = schemes[indexPath.row + 5]
                }
            }
        }
        else if tableView == gradesList {
            if indexPath.section == 0{
                if let ind = grades[selectedScheme].index(of: gradesWOEmptys[selectedScheme][selectedGrade]){
                    cell.label.text = grades[indexPath.row][ind]
                }
                else{
                    cell.label.text = ""
                }
            }
             else{
     
                if let ind = grades[selectedScheme].index(of: gradesWOEmptys[selectedScheme][selectedGrade]){
                    cell.label.text = grades[indexPath.row+5][ind]
                }
                else{
                    cell.label.text = ""
                }
            }
        }
        return cell
    }
    
    
    //- HEADER
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        headerCell.backgroundColor = UIColor(displayP3Red: 0.9254902, green: 0.9254902, blue: 0.9254902, alpha: 1.0)
        
        headerCell.headerLabel.text = ""
        if tableView == schemeList{
            switch (section) {
            case 0:
                headerCell.headerLabel.text = "Routes"
            case 1:
                headerCell.headerLabel.text = "Bouldering"
            default:
                headerCell.headerLabel.text = "Other"
            }
        }
        return headerCell
    }
    
    //- SETTINGS
    
    @objc func settingsTapped(){
        performSegue(withIdentifier: "settingsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settingsSegue" {
            if let settingsViewController = segue.destination as? SettingsViewController {
                settingsViewController.selectedScheme = self.selectedScheme
            }
        }
    }
    
    func updateSelectedScheme(){
        schemeLabel.text = schemes[selectedScheme]
        gradesList.reloadData()
        selectedGradesList.reloadData()
    }
   
    
}



extension String
{
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat
    {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height);
        
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return boundingBox.width;
    }
}

