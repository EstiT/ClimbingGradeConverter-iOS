//
//  SettingsViewController.swift
//  GradeConverter
//
//  Created by Esti Tweg on 2018-05-17.
//  Copyright © 2018 Esti Tweg. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var closeImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SettingsViewController.closeTapped))
        singleTap.numberOfTapsRequired = 1
        closeImageView.addGestureRecognizer(singleTap)
        closeImageView.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func closeTapped(){
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }

}
