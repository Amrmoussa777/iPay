//
//  payment.swift
//  ipay
//
//  Created by Amr Moussa on 9/10/20.
//  Copyright © 2020 Amr Moussa. All rights reserved.
//

import Foundation
import RealmSwift
class Payment: Object {
   @objc  dynamic var  payment :String = ""
    @objc dynamic var amount:Double = 0.0
    @objc dynamic var  date:Date? = Date()
    var parentCategory =  LinkingObjects(fromType: CategoryItem.self, property: "payments")
    
}
