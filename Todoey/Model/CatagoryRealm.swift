//
//  CatagoryRealm.swift
//  Todoey
//
//  Created by Ahmed Ahmed on 1/25/19.
//  Copyright © 2019 MrRadix. All rights reserved.
//

import Foundation
import RealmSwift

class CatagoryRealm: Object{
    @objc dynamic var name: String = ""
    let items = List<ItemRealm>()
}
