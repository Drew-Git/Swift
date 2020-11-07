//
//  Player.swift
//  keepTime
//
//  Created by 김선종 on 2020/10/03.
//  Copyright © 2020 drewVvv. All rights reserved.
//

import Foundation
import RealmSwift


class Player : Object {
    @objc dynamic var name: String = ""
    @objc dynamic var position: String = ""
    @objc dynamic var age: Int = Int()
}
