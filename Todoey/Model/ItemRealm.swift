//
//  ItemRealm.swift
//  Todoey
//
//  Created by Ahmed Ahmed on 1/25/19.
//  Copyright © 2019 MrRadix. All rights reserved.
//

import Foundation
import RealmSwift

class ItemRealm: Object{
    @objc dynamic var title: String = ""
    @objc dynamic var done: Bool = false
    @objc dynamic var dateCreated: Date = Date()
    var parentCatagory = LinkingObjects(fromType: CatagoryRealm.self, property: "items")
}
