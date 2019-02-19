//
//  DataModel.swift
//  Todoey
//
//  Created by Ahmed Ahmed on 12/14/18.
//  Copyright © 2018 MrRadix. All rights reserved.
//

import Foundation
import RealmSwift

class DataModel: Object{
    @objc dynamic var neme: String = ""
    @objc dynamic var age: Int = 0
    
    convenience init(name: String,age: Int){
        self.init()
        self.neme = name
        self.age = age
    }
}
