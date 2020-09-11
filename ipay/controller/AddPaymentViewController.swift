//
//  AddPaymentViewController.swift
//  ipay
//
//  Created by Amr Moussa on 9/10/20.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit
import RealmSwift
class AddPaymentViewController: UIViewController{
    var category:CategoryItem?
    weak var delegate :newpaymentadded?
    @IBOutlet weak var paymentName: UITextField!
    @IBOutlet weak var amountTxtFeild: UITextField!
    let realm = try! Realm()
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    @IBAction func savebuttonpressed(_ sender: Any) {
        if let currentCategory = self.category {
            do {
                try self.realm.write {
                    let newpayment = Payment()
                    newpayment.payment = paymentName.text!
                    newpayment.date = Date()
                    newpayment.amount = Double(amountTxtFeild.text!)!
                    currentCategory.payments.append(newpayment)
                     self.dismiss(animated: true)
                    if let  delegate = self.delegate{
                        delegate.loadData()
                    }
                   
                }
            } catch {
                print("Error saving new parment, \(error)")
            }
        }
        
        
    }
    
}
protocol  newpaymentadded:NSObjectProtocol {
    func loadData()
}
