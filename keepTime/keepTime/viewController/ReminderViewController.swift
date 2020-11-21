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
    var isHiddenCheckBox = true
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {       //주어진 행에 맞는 데이터 소스 읽기
        let row = self.list[indexPath.row]
        NSLog("선택된 행은 \(indexPath.row) 번째 행입니다")
        NSLog("선택된 행은 \(row) 번째 행입니다")
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ReminderListCell") as! ReminderViewCell
//        cell.deleteBtnCell.setImage(UIImage(named: "stop.fill"), for: .selected)

        
        
//            let reminderViewCell =  ReminderViewCell() // default
//            reminderViewCell.deleteBtnCell!.setImage(UIImage(named: "stop.fill"), for: .selected)
        
        //테이블에서 선택시 막는 방법 (storyboard에선 지워야함
//        if(!isHiddenCheckBox) {
//            return
//        } else {
//            let vc = self.storyboard!.instantiateViewController(withIdentifier: "ReminderInsertController") as! ReminderInsertController
//                    vc.modalPresentationStyle = UIModalPresentationStyle.fullScreen
//                    // Property 값 셋팅
//    //                vc.delegate = self
//
//                    self.present(vc, animated: true)
//
//        }
        
        
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
        cell.seqCell = row.reminder_seq
        cell.contentsCell?.text = row.contents
        cell.endDateCell?.text = "마감시간 : " + dateFormatter.string(from: row.endDate)
//        cell.tagCell?.text = row.colorTag
        cell.tagCell.backgroundColor = UIColor.blue
        // 입력할날짜 - 완료예정일 / 오늘날짜 - 완료예정일 x 100%
//        row.endDate - row.insertDate / Date() - row.insertDate
        cell.deleteBtnCell.isHidden = isHiddenCheckBox
        
        //남은 날짜
        let period = (row.endDate.timeIntervalSince(row.insertDate))
//        //지난 시간
        let pastTime = (Date().timeIntervalSince(row.insertDate))
        //남은 시간
//        let leaveTime = row.endDate.timeIntervalSince(Date())
//        1 - Float(period - leaveTime)
        NSLog("period   : \(period) = endDate : \(row.endDate) - today : \(row.insertDate)")
        NSLog("pastDate : \(pastTime) = Date() : \(Date()) - row.insertDate : \(row.insertDate)")
        NSLog("period : \(period), pastDate : \(pastTime)")
        
        var progress = CGFloat(pastTime/period)
        NSLog("before scaling progress : \(progress)")
//        var limitOrPassDate = ""
        if(progress > 1) {
            progress = 1
            
//            (pastTime / 86400)
//            limitOrPassDate = pastTime
        } else if (0 <= progress && progress < 0.03 ){ //1%보다 작으면 1%로 처리
            progress = 0.03
//            limitOrPassDate = period
        } else if (progress < 0 ) {
            progress = -progress
            if (progress > 1 ) {
                progress = 1
            }
        } else {
        }
        NSLog("after scaling progress : \(progress)")
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
    @IBAction func deleteCheckAction(_ sender: UIButton) {
//        sender.state
    }
    @IBAction func handleGesture(_ sender: UILongPressGestureRecognizer) {
        print(#function, sender)
        if (sender.state == .began) {
            print("began", sender.state)
            isHiddenCheckBox = !isHiddenCheckBox
            
            reminderTableView.reloadData()
//            reminderViewCell.deleteBtnCell.isHidden = false
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return isHiddenCheckBox
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let reminderIVC = segue.destination as! ReminderInsertController
        
        if segue.identifier == "insertSegue" {
            
            reminderIVC.delegate = self
            
        }
        
        if segue.identifier == "selectDeSegue" {
            self.shouldPerformSegue(withIdentifier: "selectDeSegue", sender: sender)

            let reminderDetail = sender as! ReminderViewCell

            reminderIVC.seq = reminderDetail.seqCell
        }
        
    }
    
    
}

