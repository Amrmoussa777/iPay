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
    override func viewDidAppear(_ animated: Bool) {
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
            cell.percentage = category.payments.sum(ofProperty: "amount") / category.expenses
            cell.categNmae.text = category.categoryname
            cell.budget.text = String(category.expenses) + "$"
//            cell.percentage = category.payments.sum(ofProperty: "amount") / category.expenses
         
            let df = DateFormatter()
            df.dateFormat = "EEE, MMM d  hh:mm aaa"
            let date = df.string(from: category.date!)
            cell.Date.text = date
            cell.contentView.layer.cornerRadius = 10
            cell.clipsToBounds = true
        }
        return cell
    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        loadDataFrmDB()
//    }
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
    var percentage:Double?{
        didSet{
           loadprogress(percentage!)
        }
    }

    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var categNmae: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var budget: UILabel!
    @IBOutlet weak var circularView: UIView!
    
    let shapelayer = CAShapeLayer()
    
    func loadprogress(_ percentage:Double){
        
      
        
        percentageLabel.text = String("\(Int(percentage * 100))%" )
        percentageLabel.textAlignment = .center
         let center = circularView.center
                    // create my track layer
                        let trackLayer = CAShapeLayer()
                        print(percentage)
//        let angel = M_PI * 2 * GFloat.init(percentage) - M_PI_2C
//        print("Angel :     \(angel)")
        let circularPath = UIBezierPath(arcCenter: center , radius: CGFloat(30), startAngle: CGFloat(-M_PI_2), endAngle:CGFloat(M_PI * 2 * percentage - M_PI_2), clockwise: true)
        let trackPath = UIBezierPath(arcCenter: center, radius: 30, startAngle: -CGFloat.pi / 2, endAngle:   2 * CGFloat.pi, clockwise: true)
                        trackLayer.path = trackPath.cgPath
                        
                        trackLayer.strokeColor = #colorLiteral(red: 0.9411764706, green: 0.5411764706, blue: 0.3647058824, alpha: 0.1156624572)
                        trackLayer.lineWidth = 5
                        trackLayer.fillColor = UIColor.clear.cgColor
                trackLayer.lineCap = CAShapeLayerLineCap.round
                        circularView.layer.addSublayer(trackLayer)
                        
                    
                        shapelayer.path = circularPath.cgPath
            
                shapelayer.strokeColor = #colorLiteral(red: 0.9411764706, green: 0.5411764706, blue: 0.3647058824, alpha: 1)
                        shapelayer.lineWidth = 5
                        shapelayer.fillColor = UIColor.clear.cgColor
                shapelayer.lineCap = CAShapeLayerLineCap.round
                        
                        shapelayer.strokeEnd = 0
                        
                        circularView.layer.addSublayer(shapelayer)
                
        //       nanimate
                let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
                
                basicAnimation.toValue = 1
                
                basicAnimation.duration = 2
                
                basicAnimation.fillMode = CAMediaTimingFillMode.forwards
                basicAnimation.isRemovedOnCompletion = false
                
                shapelayer.add(basicAnimation, forKey: "urSoBasic")
                
                }
    }
    
        
        
    
    
    
    















//extension UIImageView {
//  public func maskCircle(anyImage: UIImage) {
//    self.contentMode = UIView.ContentMode.scaleAspectFit
//    self.layer.cornerRadius = self.frame.height / 2
//    self.layer.masksToBounds = false
//    self.clipsToBounds = true
//
//   // make square(* must to make circle),
//   // resize(reduce the kilobyte) and
//   // fix rotation.
//   self.image = anyImage
//  }
//}
