//
//  payentViewController.swift
//  ipay
//
//  Created by Amr Moussa on 9/10/20.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import UIKit
import RealmSwift
class payentViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
   
    var parentCategory:CategoryItem?
    var paymentsArr : Results<Payment>?
    @IBOutlet weak var paymentsTableView: UITableView!
    @IBOutlet weak var bottomPaidLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentsTableView.delegate = self
        paymentsTableView.dataSource = self
        loadpaymentsfrmDB()
        if let parent = parentCategory{
            print("<>>\(parent)<<><<")
        }
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
            df.dateFormat = "MMM d  yyyy"
            let date = df.string(from: payment.date!)
            cell.dateOfPayment.text = date
        }
        return cell
    }
    

    func loadpaymentsfrmDB(){
        paymentsArr = parentCategory?.payments.sorted(byKeyPath: "date", ascending: false)
        paymentsTableView.reloadData()
           
       }

   

}

class  paymentCell : UITableViewCell {
    
    @IBOutlet weak var paymentName: UILabel!
    @IBOutlet weak var dateOfPayment: UILabel!
    @IBOutlet weak var amountPaid: UILabel!
}
