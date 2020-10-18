//
//  Reminder.swift
//  keepTime
//
//  Created by 김선종 on 2020/10/18.
//  Copyright © 2020 drewVvv. All rights reserved.
//

import Foundation
import RealmSwift


class TB_Reminder : Object {
//    @objc dynamic var title: String = ""
    @objc dynamic var reminder_seq: Int = 0
    @objc dynamic var contents: String = ""
    @objc dynamic var endDate: Date = Date()
    @objc dynamic var insertDate: Date = Date()
    @objc dynamic var colorTag: String = ""
    
    func autoIncreaseSeq() -> Int {
        self.reminder_seq = UserDefaults.standard.integer(forKey: "primary_key") + 1
        UserDefaults.standard.set(self.reminder_seq, forKey: "primary_key")
        
        return self.reminder_seq;
    }
    
    ///Primary Key를 등록해 줍니다.
    override static func primaryKey() -> String? {
        return "reminder_seq"
    }
    
}

