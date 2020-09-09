//
//  AddCategoryViewController.swift
//  ipay
//
//  Created by Amr Moussa on 9/8/20.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController {

    @IBOutlet var cartView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        cartView.layer.cornerRadius = 10
        cartView.layer.masksToBounds = true
        cartView.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
