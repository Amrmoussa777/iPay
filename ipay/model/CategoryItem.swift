//
//  CategoryItem.swift
//  ipay
//
//  Created by Amr Moussa on 9/9/20.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import Foundation
import RealmSwift
class CategoryItem:Object{
    @objc  dynamic var  categoryname :String = ""
    @objc dynamic var expenses:Double = 0.0
//    @objc dynamic var expensesAvailable:Double = 0.0
    @objc dynamic var  date:Date? = Date()
    let payments = List<Payment>()
    
    
}
