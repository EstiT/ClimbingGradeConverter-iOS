//
//  FirstViewController.swift
//  GradeConverter
//
//  Created by Esti Tweg on 2018-04-04.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import UIKit

class RoutesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    var schemes: [String] = ["French", "UK",  "Australia", "UIAA", "North America"]
    
    var grades: [[String]] = [
        ["1-2", "2-3", "4", "4+", "5a", "5b", "6a", "6a+", "6b", "6b+", "6c", "6c+", "7a", "7a+", "7b", "7b+", "7c", "7c+", "8a", "8a+", "8b", "8b+", "8c", "8c+", "9a"],
        ["HVD", "MS", "S", "VS", "HVS", " ", "E1 5b", "E2 5c", " ", "E3 5c", " ", "E4 6a", " ", "E5 6b", " ", "E6 6b", " ", " ", "E7 6c", " ", "E8 7a", " ", "E9 7b", " ", "E10 7c"],
        ["8-9", "10-12", "13-", "13+", "14", "15", "19", "19/20", "20", "21", "21/22", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35"],
        ["I-II", "III", "IV", "V-", "V", "V+", "VI+", "VI+/VII-", "VII", "VII+", "VII+/VIII-", "VIII-", "VIII", "VIII/VIII+", "VIII+", "IX-", "IX", "IX/IX+", "IX+", "X-", "X", "X/X+", "X+", "XI-", "XI"],
        ["5.2-5.3", "5.4-5.5", "5.6", "5.7", "5.8", "5.9", "5.10a", "5.10b", "5.10c", "5.10d", "5.11a", "5.11b", "5.11c/d", "5.12a", "5.12b", "5.12c", "5.12d", "5.13a", "5.13b", "5.13c", "5.13d", "5.14a", "5.14b", "5.14c", "5.14d-5.15"]]
    

    @IBOutlet weak var selectedGradesList: UICollectionView!
    
    @IBOutlet weak var schemeList: UITableView!
    @IBOutlet weak var gradesList: UITableView!
    
    @IBOutlet weak var schemeLabel: UILabel!
    var selectedScheme = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        selectedGradesList.allowsSelection = true;
        selectedGradesList.dataSource = self
        selectedGradesList.delegate = self
        selectedGradesList.reloadData()

        schemeLabel.text = schemes[selectedScheme]
        
        schemeList.dataSource = self
        schemeList.delegate = self
        schemeList.reloadData()
        
        gradesList.dataSource = self
        gradesList.delegate = self
        gradesList.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return grades[selectedScheme].count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GradeCell", for: indexPath) as! GradeCell
        cell.gradeName = grades[selectedScheme][indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
//        let grade = grades[selectedScheme][indexPath.row]
//        deselectAll(collectionView)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GradeCell", for: indexPath) as! GradeCell
        cell.gradeNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
//        setSelectedGrade(grade)
        gradesList.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath){
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GradeCell", for: indexPath) as! GradeCell
        cell.gradeNameLabel.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.thin)
    }
    
    func deselectAll(_ sender: Any?){
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schemes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        if tableView == schemeList{
            cell.label.text = schemes[indexPath.row]
        }
        else if tableView == gradesList {
            if let i = selectedGradesList.indexPathsForSelectedItems?.first{
                cell.label.text = grades[indexPath.row][(i.row)]
            }
            else{
                cell.label.text = ""
            }
        }
        return cell
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

