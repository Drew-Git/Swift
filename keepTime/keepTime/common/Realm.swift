//
//  Realm.swift
//  keepTime
//
//  Created by 김선종 on 2020/10/25.
//  Copyright © 2020 drewVvv. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
//    let realm = try! Realm()
    
    func removerRealm(){
        
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!

        let realmURLs = [
            realmURL,
            realmURL.appendingPathExtension("lock"),
            realmURL.appendingPathExtension("note"),
            realmURL.appendingPathExtension("management")
        ]

        for URL in realmURLs {

            do {

                try FileManager.default.removeItem(at: URL)

            } catch {

                // handle error

            }

        }
    }
    
    func migrateRealm() {
            let config = Realm.Configuration(
                schemaVersion: 1,
                migrationBlock: { migration, oldSchemaVersion in
                    if (oldSchemaVersion < 1) {
                        // The enumerateObjects(ofType:_:) method iterates
                        // over every Person object stored in the Realm file
                        migration.enumerateObjects(ofType: TB_Reminder.className()) { oldObject, newObject in
                            // combine name fields into a single field
//                            newObject!["insertDate"] = ""
                        }
                    }
                })
            
            // 새로운 설정을 기본 저장소에 적용
            Realm.Configuration.defaultConfiguration = config
        }
}
