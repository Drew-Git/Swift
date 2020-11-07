//
//  FirstViewController.swift
//  keepTime
//
//  Created by 김선종 on 2020/10/03.
//  Copyright © 2020 drewVvv. All rights reserved.
//

import UIKit
import RealmSwift

class ReminderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, protocolData {
    @IBOutlet weak var reminderTableView: UITableView!
    let progressing = CustomerProgressView()
    
    let realm = try! Realm()
    
    lazy var list: [TB_Reminder] = {
        var dataList = [TB_Reminder]()
        return dataList
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 테이블 뷰 객체와 소스를 연결하고 위임 설정
        reminderTableView.delegate = self
        reminderTableView.dataSource = self
        // Do any additional setup after loading the view.

//        testRealm()
//        print(getDocumentsDirectory())
        
        self.initListView()
        NSLog("list : \(self.list) ")
        // 데이터를 다시 읽어오도록 테이블 뷰를 갱신한다.
        
        reminderTableView.reloadData()
    }
    
    func initListView(){
        self.list.removeAll()
        NSLog("initListView called ")
        let result = realm.objects(TB_Reminder.self).sorted(byKeyPath: "reminder_seq", ascending: false)
        let arr = Array(result)
        NSLog("result : \(arr) ")
//        NSLog("result : \(result) ")
//        let array = NSArray(array: Array(result))
//        NSLog("array : \(array) ")
//        let resultList = array as! [TB_Reminder]
//        NSLog("list : \(list) ")
        self.list.append(contentsOf: arr)
//        self.list.append(arr[0])
        
        NSLog("list : \(list) ")
    }
    func reloadTableViewData() {
        self.initListView()
        reminderTableView.reloadData()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 150
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.list.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      NSLog("선택된 행은 \(indexPath.row) 번째 행입니다")
    }
    
    // DB에서 읽은 데이터를 tableView cell에 입력해준다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //주어진 행에 맞는 데이터 소스 읽기
        let row = self.list[indexPath.row]
        
        //로그 출력
        NSLog("내용 : \(row.contents) , 행 번호 : \(indexPath.row)")
//        ReminderListCell
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd HH:mm"
//        dateFormatter.locale = Locale(identifier: "ko")
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderListCell") as! ReminderViewCell
        cell.contentsCell?.text = row.contents
        cell.endDateCell?.text = "마감시간 : " + dateFormatter.string(from: row.endDate)
//        cell.tagCell?.text = row.colorTag
        cell.tagCell.backgroundColor = UIColor.blue
        // 입력할날짜 - 완료예정일 / 오늘날짜 - 완료예정일 x 100%
//        row.endDate - row.insertDate / Date() - row.insertDate
        
        //남은 날짜
        let period = (row.endDate.timeIntervalSince(row.insertDate))
//        //지난 시간
        let pastTime = (Date().timeIntervalSince(row.insertDate))
        //남은 시간
//        let leaveTime = row.endDate.timeIntervalSince(Date())
//        1 - Float(period - leaveTime)
//        NSLog("period   : \(period) = endDate : \(row.endDate) - today : \(row.insertDate)")
//        NSLog("pastDate : \(pastDate) = Date() : \(Date()) - row.insertDate : \(row.insertDate)")
//        NSLog("period : \(period), pastDate : \(pastDate)")
        
        var progress = CGFloat(pastTime/period)
        NSLog("progress : \(progress)")
//        var limitOrPassDate = ""
        if(progress > 1) {
            progress = 1
            
//            (pastTime / 86400)
//            limitOrPassDate = pastTime
        } else {
//            limitOrPassDate = period
        }
//        progressing.progress = progress
//        cell.progressCell?.progress = Float(progressing.progress)
        cell.progressViewCell?.progress = progress
        
        cell.passDayCell.text = ""
    
        return cell
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "insertSegue" {
            
            let reminderVC = segue.destination as! ReminderInsertController
            reminderVC.delegate = self
            
        }
    }
    
    
}

