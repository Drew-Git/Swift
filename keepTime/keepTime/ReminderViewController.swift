//
//  FirstViewController.swift
//  keepTime
//
//  Created by 김선종 on 2020/10/03.
//  Copyright © 2020 drewVvv. All rights reserved.
//

import UIKit
import RealmSwift

class ReminderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

//        testRealm()
        print(getDocumentsDirectory())
    }
    
    func testRealm(){
        
        let realm = try! Realm() // default realm을 만든다.

        let kim = Player()
        kim.name = "andrew"
        kim.position = "DEV"
        kim.age = 28

        do {
            try realm.write{
                realm.add(kim)
            }
        } catch {
                print("Errors \(error)")
            
        }
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

