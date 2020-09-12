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
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        paymentsArr?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constant.paymentTableviewcellidentifire, for: indexPath) as! paymentCell
        if let payment = paymentsArr?[indexPath.row]{
            cell.paymentName.text = payment.payment
            cell.amountPaid.text = String(payment.amount) + "$"
            let df = DateFormatter()
            df.dateFormat = "EEE, MMM d  hh:mm aaa"
            let date = df.string(from: payment.date!)
            cell.loaded = true
            cell.dateOfPayment.text = date
        }
        return cell
    }
    
    
    func loadData(){
        paymentsArr = parentCategory?.payments.sorted(byKeyPath: "date", ascending: false)
        categoryPayments = parentCategory?.payments.sum(ofProperty: "amount")
        categoryBudget = parentCategory?.expenses
        bottomPaidLabel.text =  "Paid : \(categoryPayments!)/\(categoryBudget!)" + "$"
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
    var loaded:Bool?{
        didSet{
            loadKnots()
        }
    }
    @IBOutlet weak var knotsShapeVoew: UIView!
    @IBOutlet weak var paymentName: UILabel!
    @IBOutlet weak var dateOfPayment: UILabel!
    @IBOutlet weak var amountPaid: UILabel!
    
    let shapelayer = CAShapeLayer()
    let linePath = UIBezierPath()
    func loadKnots(){
        linePath.move(to: CGPoint(x: knotsShapeVoew.frame.width / 2, y: 0 ))
        linePath.addLine(to: CGPoint(x: knotsShapeVoew.frame.width / 2, y: knotsShapeVoew.frame.height))
        shapelayer.path = linePath.cgPath
        shapelayer.strokeColor = #colorLiteral(red: 0.9411764706, green: 0.5411764706, blue: 0.3647058824, alpha: 1)
        shapelayer.lineWidth = 5
        knotsShapeVoew.layer.sublayers?.removeAll()
        knotsShapeVoew.layer.addSublayer(shapelayer)
        //      MARK: - Design centeral circle
        let circleShape = CAShapeLayer()
        let circlepath = UIBezierPath(arcCenter: knotsShapeVoew.center, radius: 10, startAngle: -CGFloat.pi / 2, endAngle: CGFloat.pi * 2 , clockwise: true)
        circleShape.path = circlepath.cgPath
        circleShape.fillColor = #colorLiteral(red: 0.9411764706, green: 0.5411764706, blue: 0.3647058824, alpha: 1)
        circleShape.lineCap = CAShapeLayerLineCap.round
        knotsShapeVoew.layer.addSublayer(circleShape)
        
    }
}
