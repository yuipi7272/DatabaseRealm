//
//  Memo.swift
//  DatabaseRealm
//
//  Created by Yui Ogawa on 2022/08/31.
//

import Foundation
import RealmSwift

class Memo: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var content: String = ""
}
