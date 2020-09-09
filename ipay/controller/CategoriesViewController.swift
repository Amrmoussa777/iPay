//
//  ViewController.swift
//  ipay
//
//  Created by Amr Moussa on 9/7/20.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit

class CategoriesViewController : UIViewController , UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var categeoryTableView: UITableView!
    
    let expensesArray = [500,600,190]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  expensesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: constant.tableViewCellIdentifier)
        cell.textLabel?.text = String(expensesArray[indexPath.row])
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        categeoryTableView.delegate = self
        categeoryTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }


}

