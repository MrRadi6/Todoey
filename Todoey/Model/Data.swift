//
//  Data.swift
//  Todoey
//
//  Created by Ahmed Ahmed on 12/10/18.
//  Copyright © 2018 MrRadix. All rights reserved.
//

import Foundation

class Data: Encodable,Decodable{
    var item: String = ""
    var isChecked: Bool = false
    
    init(item: String, isChecked: Bool){
        self.item = item
        self.isChecked = isChecked
    }
}
