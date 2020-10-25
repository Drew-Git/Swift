//
//  ReminderInsertController.swift
//  keepTime
//
//  Created by 김선종 on 2020/10/18.
//  Copyright © 2020 drewVvv. All rights reserved.
//

import UIKit
import RealmSwift

class ReminderInsertController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var endDate: UIDatePicker!
    let seq : Int? = 18
    let reminder = TB_Reminder()
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        removerRealm()
//        migrateRealm()
//        let seq : Int? = nil
//        let seq : Int? = 13
        initDetailView(seq : seq)
        
        // Do any additional setup after loading the view.
    }
    
    // 1-1
    func initDetailView(seq: Int?) {
        
        //MARK: change it if better code avalible
        // if seq
        // show select item in insert box
        // if not seq
        // show insert box
        if(seq != nil){
            reminder.reminder_seq = seq!
            let selectItem = selectData(rData: reminder)
            showDetail(rData: selectItem)
        }
        
    }
    // insert Object
    func insertData(_ rData : TB_Reminder) -> TB_Reminder{
        rData.contents = self.contents.text
        rData.endDate = self.endDate.date//종료 설정일
        rData.insertDate = Date() //입력일
        
        return rData
    }
    // 1-2
    func selectData(rData: TB_Reminder) -> TB_Reminder {
//        rData.reminder_seq = 13
//        let rDatas = realm.objects(TB_Reminder.self)
//        print(rDatas)
        let selectData = realm.objects(TB_Reminder.self).filter("reminder_seq=\(rData.reminder_seq)").first!
        print(selectData)
        return selectData
    }
    
    // 1-3
    func showDetail(rData: TB_Reminder) {
        self.contents.text = rData.contents
        self.endDate.date = rData.endDate
    }
    
    @IBAction func insertOrUpdateReminder(_ sender: UIButton) {
        
        do{
            try realm.write{ // realm.write{}는 git에서 commit을 해주는 것과 비슷하다.
                if(seq == nil) {
                    reminder.reminder_seq = reminder.autoIncreaseSeq()
                    let data = insertData(reminder)
                    realm.add(data, update: .modified) // 데이터베이스에 reminderData 모델을 더한다.
                } else {
                    if let obj = realm.objects(TB_Reminder.self).filter("reminder_seq=\(seq!)").first {
                        //MARK: Question _ 
                        _ = insertData(obj)
                    }
                }
            }
        } catch {
            print("Error Add \(error)")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
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
//    func checkValidate() {
//        var contentsText = self.contents.text
//        var contentsDate = self.endDate.date
//
//        if(contentsText == "") {
//
//        }
//
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
