//
//  ViewController.swift
//  ipay
//
//  Created by Amr Moussa on 9/7/20.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit
import RealmSwift
class CategoriesViewController : UIViewController , UITableViewDataSource, UITableViewDelegate ,newCategoryAddeddprotocol {
    
    @IBOutlet weak var bottomBugetLabel: UILabel!
    var expenses:Double?
    var budget:Double?
  func newCategoryadedupdate() {
       loadDataFrmDB()
  }
    
    @IBOutlet weak var categeoryTableView: UITableView!
      let realm = try! Realm()
    var categorrieArray :Results<CategoryItem>?
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  categorrieArray?.count ?? 0 
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: constant.tableViewCellIdentifier, for: indexPath) as! categorycell
        if let category = categorrieArray?[indexPath.row]{
        cell.categNmae.text = category.categoryname
        cell.budget.text = String(category.expenses)
        let df = DateFormatter()
        df.dateFormat = "EEE, MMM d \n hh:mm aaa"
        let date = df.string(from: category.date!)
        cell.Date.text = date
      
        }
          return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        categeoryTableView.delegate = self
        categeoryTableView.dataSource = self
        loadDataFrmDB()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
       
        
        // Do any additional setup after loading the view.
    }

    
    func loadDataFrmDB() {
        categorrieArray =  realm.objects(CategoryItem.self)
        budget = realm.objects(CategoryItem.self).sum(ofProperty:"expenses")
        expenses = realm.objects(Payment.self).sum(ofProperty:"amount")
        categeoryTableView.reloadData()
        bottomBugetLabel.text = "\(expenses!)/\(budget!)"
        if expenses! / budget! > 0.80 {
            bottomBugetLabel.backgroundColor =
            .systemRed
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if(segue.identifier == constant.addCategorySegue){
                let displayVC = segue.destination as! AddCategoryViewController
                displayVC.delegate = self
            }
        if(segue.identifier == constant.selectCatergory){
            let displayVC = segue.destination as! payentViewController
            print(constant.selectCatergory)
            if let index = categeoryTableView.indexPathForSelectedRow{
                displayVC.parentCategory = categorrieArray?[index.row]
            }
            
        }
    }
    
   
  
}
class categorycell : UITableViewCell {
    @IBOutlet weak var categNmae: UILabel!
    
    @IBOutlet weak var Date: UILabel!
    
    @IBOutlet weak var budget: UILabel!
}
