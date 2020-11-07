//
//  Date.swift
//  keepTime
//
//  Created by 김선종 on 2020/11/01.
//  Copyright © 2020 drewVvv. All rights reserved.
//

import Foundation

extension Date {
    func getKST() -> Date {
        return Calendar.current.date(byAdding: .hour, value: 9, to: self)!
    }
    
    func limitDate(time: TimeInterval) -> String {
        
        return ""
    }
}
