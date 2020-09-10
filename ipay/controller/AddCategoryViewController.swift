//
//  AddCategoryViewController.swift
//  ipay
//
//  Created by Amr Moussa on 9/8/20.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit
import RealmSwift
class AddCategoryViewController: UIViewController {
    @IBOutlet var cartView: UIView!
    weak var  delegate : newCategoryAddeddprotocol?
    
    @IBOutlet weak var categoryTxtFeild: UITextField!
    
    @IBOutlet weak var expensesTxtFeild: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var addCategoryBtn: UIButton!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        cartView.layer.cornerRadius = 10
        cartView.layer.masksToBounds = true
        cartView.clipsToBounds = true
        
        
    }
    
    @IBAction func addBtnClicked(_ sender: UIButton) {
          
          let category = CategoryItem()
          category.categoryname = categoryTxtFeild.text!
          category.expenses = Double(expensesTxtFeild.text!)!
          print(datePicker.date)
          category.date =  datePicker.date
          do{
              let rlm = try Realm()
              //            deleteRealmIfMigrationNeeded = false
              try rlm.write {
                  rlm.add(category)
                  print(Realm.Configuration.defaultConfiguration.fileURL!)
                if let delegate = self.delegate{
                    delegate.newCategoryadedupdate()
                }
                self.dismiss(animated: true) {
                    
                }
            }
          }catch{
              print("error while establishing db \(error)")
              
          }
          
          
          
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
protocol newCategoryAddeddprotocol:NSObjectProtocol{
    func newCategoryadedupdate()
}
