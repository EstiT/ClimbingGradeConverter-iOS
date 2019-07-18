//
//  FirstViewController.swift
//  GradeConverter
//
//  Created by Esti Tweg on 2018-04-04.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import UIKit

class RoutesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource {
    
    var schemes: [String] = ["Ewbank", "YDS",  "French", "UK", "UIAA", "Hueco", "Font"]
    
    var grades: [[String]] = [
        ["5", "6", "7", "8/9", "10/11", "12/13", "14", "15", "16", "17", "18", "19", "20", "20/21", "21", "22", "22/23", "23/24", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39"],
        
        ["5.0", "5.1", "5.2", "5.3", "5.4", "5.5", "5.6", "5.7", "5.8", "5.9", "5.10a", "5.10b", "5.10c", "5.10d", "5.11a", "5.11b", "5.11c", "5.11d", "5.12a", "5.12b", "5.12c", "5.12d", "5.13a", "5.13b", "5.13c", "5.13d", "5.14a", "5.14b", "5.14c", "5.14d", "5.15a", "5.15b", "5.15c", "5.15d"],
        
        ["2", "3a" , "3b", "3c", "4a", "4b", "4c", "5a", "5b", "5c", "6a", "6a+", "6b", "6b+",  "6c", "6c+", "6c+/7a", "7a", "7a+", "7b", "7b+", "7c", "7c+", "8a", "8a+", "8b" ,"8b+" , "8c", "8c+", "9a", "9a+", "9b", "9b+", "9c"],
        
        ["2", "2", "3", "3", "4a", "4b", "4b", "4c", "4c", "5a", "5a", "5b", "5b", "5b/5c", "5c", "5c", "5c/6a", "6a", "6a", "6b", "6b", "6b/6c", "6c", "6c", "6c/7a", "7a", "7a", "7b", "7b", "7b/7c", "7c", "7c",  "7c+", "7c+"],
        
        ["I", "II", "III", "III+", "IV-", "IV", "IV+", "V-", "V", "V+/VI-", "VI", "VI+", "VII-", "VII", "VII+", "VII+/VIII-", "VIII-", "VIII", "VIII/VIII+", "VIII+", "IX-", "IX", "IX/IX+", "IX+", "X-", "X", "X+", "XI-", "XI", "XI+","XII-","XII","XII/XII+", "XII+"],
        
        ["","","","","","", "VB-", "VB", "VB+", "V0-", "V0", "V0/V1", "V1/V2", "V2", "V2/V3", "V3", "V3/V4", "V4", "V4/V5", "V5", "V6", "V6/V7", "V7", "V8", "V9", "V10", "V11", "V12", "V12/V13", "V13",  "V14", "V15", "V16", "V17"],
        
        ["","","","","","", "2","2+", "3", "3+","4", "4+", "5", "5+", "6a", "6a+", "6b", "6b+", "6c", "6c+", "7a", "7a/7a+", "7a+", "7b/7b+", "7c", "7c+", "8a", "8a+", "8a+/8b", "8b", "8b+", "8c", "8c+", "9a"]]
  
    

    @IBOutlet weak var selectedGradesList: UICollectionView!
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var schemeList: UITableView!
    @IBOutlet weak var gradesList: UITableView!
    
    @IBOutlet weak var schemeLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    
    var selectedScheme = 0
    var selectedGrade = 0
    
    var firstOpen: Bool!
    var singleTap: UITapGestureRecognizer!
    @IBOutlet var text: UILabel!
    @IBOutlet var arrowView: UIView!
    @IBOutlet var triangleView: UIView!
    var haze: UIView!
    
    @IBOutlet weak var schemeWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var schemeLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var gradeTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var slideToTableConstraint1: NSLayoutConstraint!
    @IBOutlet weak var labelToSlideConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //restore preferences
        selectedScheme = UserDefaults.standard.integer(forKey: "selectedScheme")
        selectedGrade = UserDefaults.standard.integer(forKey: "selectedGrade")
        selectedGradesList.allowsSelection = false
        selectedGradesList.dataSource = self
        selectedGradesList.delegate = self
        selectedGradesList.reloadData()

        schemeLabel.text = schemes[selectedScheme]
        schemeList.dataSource = self
        schemeList.delegate = self
        schemeList.reloadData()
        schemeList.tableFooterView = UIView(frame: .zero)
        schemeList.backgroundColor = .clear
        schemeList.separatorColor = .black
        
        gradesList.dataSource = self
        gradesList.delegate = self
        gradesList.reloadData()
        gradesList.tableFooterView = UIView(frame: .zero)
        gradesList.backgroundColor = .clear
        gradesList.separatorColor = .black

        //Scroll to closest selected grade
        var index = IndexPath()
        if selectedScheme == 4 || selectedScheme == 5 {
            index = IndexPath(row: selectedGrade-6, section: 0)
        }
        else{
            index = IndexPath(row: selectedGrade, section: 0)
        }
        selectedGradesList.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
        
        collectionViewFlowLayout = selectedGradesList.collectionViewLayout as? UICollectionViewFlowLayout
        selectedGradesList.contentInset.left = collectionViewFlowLayout.itemSize.width + collectionViewFlowLayout.minimumLineSpacing + 20
        selectedGradesList.contentInset.right = collectionViewFlowLayout.itemSize.width + collectionViewFlowLayout.minimumLineSpacing + 20
        
        triangleView.layer.zPosition = 1
        
        if !isKeyPresentInUserDefaults(key: "firstOpen") {
            firstOpen = true
        }
        else{
            firstOpen = UserDefaults.standard.bool(forKey: "firstOpen")
        }
        if firstOpen {
            startOnboarding()
        }
        if UIDevice.current.userInterfaceIdiom == .pad {
            iPadLayout()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        selectedGrade = UserDefaults.standard.integer(forKey: "selectedGrade")
        updateSelectedScheme()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startOnboarding(){
        haze = UIView(frame: self.view.frame)
        haze.backgroundColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: 0.75)
        self.view.addSubview(haze)
        
        haze.layer.zPosition = 2
        arrowView.layer.zPosition = 3
        text.layer.zPosition = 3
        
        setArrowPosition()
        arrowView.transform = arrowView.transform.rotated(by: CGFloat(-Double.pi/6))
        
        
        text.isHidden = false
        arrowView.isHidden = false
        self.view.bringSubviewToFront(arrowView)
        self.view.bringSubviewToFront(text)
        
        singleTap = UITapGestureRecognizer(target: self, action: #selector(RoutesViewController.removeShowOnboarding))
        singleTap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(singleTap)
        self.view.isUserInteractionEnabled = true
    }
    
    @objc func removeShowOnboarding(){
        if !text.isHidden && text.text == "Set your preferred scheme here"{ //change from first to second
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
                self.text.alpha = 0.0
                self.arrowView.alpha = 0.0
            }, completion: {
                (value: Bool) in
                self.text.removeFromSuperview()
                self.arrowView.removeFromSuperview()
          
                self.arrowView = ArrowView()
                self.arrowView.frame = CGRect(x: 45, y: self.schemeLabel.frame.minY+30, width: 73, height: 64)
                self.arrowView.alpha = 0.0
                self.view.addSubview(self.arrowView)
                self.arrowView.backgroundColor = .clear
                
                self.text = UILabel()
                self.text.frame = CGRect(x: 60, y: self.arrowView.frame.minY+40, width: 300, height: 80)
                self.text.center.x = self.view.center.x
                self.text.text = "Scroll here to select a grade"
                self.text.textColor = UIColor(displayP3Red: 102/255, green: 11/255, blue: 19/255, alpha: 1.0)
                self.text.font = UIFont(descriptor: UIFontDescriptor(name: "Avenir-Heavy", size: 26.0), size: 26.0)
                self.text.numberOfLines = 2
                self.text.textAlignment = .center
                self.text.alpha = 0.0
                self.view.addSubview(self.text)
                
                self.arrowView.layer.zPosition = 3
                self.text.layer.zPosition = 3

                UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
                    self.text.alpha = 1.0
                    self.arrowView.alpha = 1.0
                })
            })
        }
        else {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut, animations: {
                self.text.alpha = 0.0
                self.arrowView.alpha = 0.0
                self.haze.alpha = 0.0
            }, completion: {
                (value: Bool) in
                self.text.removeFromSuperview()
                self.arrowView.removeFromSuperview()
                self.haze.removeFromSuperview()
                UserDefaults.standard.set(false, forKey: "firstOpen")
                self.view.removeGestureRecognizer(self.singleTap)
            })
        }
    }
    
    func setArrowPosition(){
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                arrowView.frame = CGRect(x: self.view.frame.maxX-settingsButton.frame.maxX-settingsButton.frame.width*2, y: settingsButton.frame.maxY, width: 73, height: 64)
                
            case 1334:
                print("iPhone 6/6S/7/8")
                arrowView.frame = CGRect(x: self.view.frame.maxX-settingsButton.frame.maxX-settingsButton.frame.width*2, y: settingsButton.frame.maxY, width: 73, height: 64)
                
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                arrowView.frame = CGRect(x: self.view.frame.maxX-settingsButton.frame.maxX-settingsButton.frame.width*2, y: settingsButton.frame.maxY, width: 73, height: 64)
                
            case 2436:
                print("iPhone X, XS")
                arrowView.frame = CGRect(x: self.view.frame.maxX-settingsButton.frame.maxX-settingsButton.frame.width*2, y: settingsButton.frame.maxY+settingsButton.frame.height/2, width: 73, height: 64)
                
            case 2688:
                print("iPhone XS Max")
                arrowView.frame = CGRect(x: self.view.frame.maxX-settingsButton.frame.maxX-settingsButton.frame.width*2, y: settingsButton.frame.maxY+settingsButton.frame.height/2, width: 73, height: 64)
                
            case 1792:
                print("iPhone XR")
                arrowView.frame = CGRect(x: self.view.frame.maxX-settingsButton.frame.maxX-settingsButton.frame.width*2, y: settingsButton.frame.maxY+settingsButton.frame.height/2, width: 73, height: 64)
                
            default:
                print("Unknown")
                arrowView.frame = CGRect(x: self.view.frame.maxX-settingsButton.frame.maxX-settingsButton.frame.width*2, y: settingsButton.frame.maxY+settingsButton.frame.height/2, width: 73, height: 64)
            }
        }
    }
    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    // Adjust for iPad
    func iPadLayout(){
        schemeWidthConstraint.constant = self.view.frame.width/2
        schemeLeadingConstraint.constant = schemeLeadingConstraint.constant + 10
        gradeTrailingConstraint.constant = gradeTrailingConstraint.constant + 10
        slideToTableConstraint1.constant = slideToTableConstraint1.constant + 10
        labelToSlideConstraint.constant = labelToSlideConstraint.constant + 10
        schemeLabel.font = schemeLabel.font.withSize(40)
    }
    
    // MARK: COLLECTION VIEW
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if selectedScheme == 4 || selectedScheme == 5 { //bouldering
            return grades[selectedScheme].count - 6
        }
        else{
            return grades[selectedScheme].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GradeCell", for: indexPath) as! GradeCell
        if selectedScheme == 4 || selectedScheme == 5 { //bouldering
            cell.gradeName = grades[selectedScheme][indexPath.row+6]
        }
        else{
            cell.gradeName = grades[selectedScheme][indexPath.row]
        }
        return cell
    }
    
    func snapToCenter() {
        let center = self.view.convert(selectedGradesList.center, to: selectedGradesList)
        if let centerIndexPath = selectedGradesList.indexPathForItem(at: center){
            selectedGradesList.scrollToItem(at: centerIndexPath, at: .centeredHorizontally, animated: true)
            if selectedScheme == 4 || selectedScheme == 5 {
                selectedGrade = centerIndexPath.row + 6
            }
            else{
               selectedGrade = centerIndexPath.row
            }
            UserDefaults.standard.set(selectedGrade, forKey: "selectedGrade")
        }
        else{ //landed in the middle
            let center2 = CGPoint(x: center.x + 5, y: center.y)
            if let centerIndexPath = selectedGradesList.indexPathForItem(at: center2){
                selectedGradesList.scrollToItem(at: centerIndexPath, at: .centeredHorizontally, animated: true)
                if selectedScheme == 4 || selectedScheme == 5 {
                    selectedGrade = centerIndexPath.row + 6
                }
                else{
                    selectedGrade = centerIndexPath.row
                }
                UserDefaults.standard.set(selectedGrade, forKey: "selectedGrade")
            }
            else{
                let center3 = CGPoint(x: center.x - 5, y: center.y)
                if let centerIndexPath = selectedGradesList.indexPathForItem(at: center3){
                    selectedGradesList.scrollToItem(at: centerIndexPath, at: .centeredHorizontally, animated: true)
                    if selectedScheme == 4 || selectedScheme == 5 {
                        selectedGrade = centerIndexPath.row + 6
                    }
                    else{
                        selectedGrade = centerIndexPath.row
                    }
                    UserDefaults.standard.set(selectedGrade, forKey: "selectedGrade")
                }
            }
        }
        gradesList.reloadData()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        snapToCenter()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        snapToCenter()
    }
    
    
    // MARK: TABLE VIEW
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch section {
        case 0:
            return 5 //routes
        case 1:
            return 2 //bouldering
        default:
            return 8
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! TableCell
        cell.backgroundColor = .clear
        if tableView == schemeList {
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
                cell.label.text = grades[indexPath.row][selectedGrade]
            }
             else{
                cell.label.text = grades[indexPath.row+5][selectedGrade]
            }
        }
        return cell
    }
    
    
    //- HEADER
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let  headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as! HeaderCell
        headerCell.backgroundColor = UIColor(displayP3Red: 102/255, green: 11/255, blue: 19/255, alpha: 1.0)
            //displayP3Red: 103/255, green: 42/255, blue: 47/255, alpha: 1.0)
        
        headerCell.headerLabel.textColor = .white
            //UIColor(displayP3Red: 0.9254902, green: 0.9254902, blue: 0.9254902, alpha: 0.7)
            //.lightGrey
        
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
    
    @IBAction func settingsTapped(_ sender: Any) {
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
        
        var index = IndexPath()
        if selectedScheme == 4 || selectedScheme == 5 {
            index = IndexPath(row: selectedGrade-6, section: 0)
        }
        else{
            index = IndexPath(row: selectedGrade, section: 0)
        }
        selectedGradesList.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
        
    }
   
    
}



extension String
{
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat
    {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height);
        
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return boundingBox.width;
    }
}

