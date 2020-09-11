//
//  payentViewController.swift
//  ipay
//
//  Created by Amr Moussa on 9/10/20.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit
import RealmSwift
class payentViewController: UIViewController , UITableViewDelegate,UITableViewDataSource,newpaymentadded {
    let realm = try! Realm()
    var categoryPayments:Double?
    var categoryBudget:Double?
    
    
    var parentCategory:CategoryItem?
    var paymentsArr : Results<Payment>?
    @IBOutlet weak var paymentsTableView: UITableView!
    @IBOutlet weak var bottomPaidLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentsTableView.delegate = self
        paymentsTableView.dataSource = self
        loadData()
        //        if let parent = parentCategory{
        ////            print("<>>\(parent)<<><<")
        //        }
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        paymentsArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constant.paymentTableviewcellidentifire, for: indexPath) as! paymentCell
        if let payment = paymentsArr?[indexPath.row]{
            cell.paymentName.text = payment.payment
            cell.amountPaid.text = String(payment.amount)
            let df = DateFormatter()
            df.dateFormat = "EEE, MMM d \n hh:mm aaa"
            let date = df.string(from: payment.date!)
            cell.dateOfPayment.text = date
        }
        return cell
    }
    
    
    func loadData(){
        paymentsArr = parentCategory?.payments.sorted(byKeyPath: "date", ascending: false)
        categoryPayments = parentCategory?.payments.sum(ofProperty: "amount")
        categoryBudget = parentCategory?.expenses
        bottomPaidLabel.text =  "Paid : \(categoryPayments!)/\(categoryBudget!)"
        if categoryPayments! / categoryBudget! > 0.80 {
            bottomPaidLabel.backgroundColor =
            .systemRed
        }
        paymentsTableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == constant.addNewPaymentSegue){
            let destVC = segue.destination as! AddPaymentViewController
            destVC.category = parentCategory
            destVC.delegate = self
        }
    }
    
}

class  paymentCell : UITableViewCell {
    
    @IBOutlet weak var paymentName: UILabel!
    @IBOutlet weak var dateOfPayment: UILabel!
    @IBOutlet weak var amountPaid: UILabel!
}
