//
//  ReminderInsertController.swift
//  keepTime
//
//  Created by 김선종 on 2020/10/18.
//  Copyright © 2020 drewVvv. All rights reserved.
//

import UIKit
import RealmSwift
protocol protocolData {
    func reloadTableViewData()
}
class ReminderInsertController: UIViewController, UITextViewDelegate, UIPopoverPresentationControllerDelegate {
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var colorPopBtn: UIButton!
    var seq : Int?
    let reminder = TB_Reminder()
    let realm = try! Realm()
    var delegate: protocolData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        removerRealm()
//        migrateRealm()
//        let seq : Int? = nil
//        let seq : Int? = 13
        initDetailView(seq : seq)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func showPopoverButtonAction(_ sender: Any) {
        NSLog("ReminderInsertController - showPopoverButtonAction")
        // 1
        //get the button frame
        let button = sender as! UIButton
        let buttonFrame = button.frame
        
        let senderPoint = button.convert(CGPoint(x: -(buttonFrame.origin.x+20), y: -buttonFrame.origin.y), to: self.view)
        print(#function,senderPoint)
        let rect = CGRect(origin: senderPoint,
                          size: CGSize(width: 1, height: 1))
        
        //2
        // configure the presentation controller
//        self.storyboard?.instantiateViewController(withIdentifier: <#T##String#>)
        let PopoverColorPickerViewController = self.storyboard?.instantiateViewController(withIdentifier: "PopoverColorPickerViewController") as? PopoverColorPickerViewController
        PopoverColorPickerViewController?.modalPresentationStyle = .popover
        PopoverColorPickerViewController?.preferredContentSize = CGSize(width: 100, height: 180)
        
        //3
        if let popoverPresentationController = PopoverColorPickerViewController?.popoverPresentationController {
            popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = rect
//            popoverPresentationController.popoverLayoutMargins = UIEdgeInsets(top: 100, left: 100, bottom: 0, right: 0)
            popoverPresentationController.delegate = self
            if let popoverController = PopoverColorPickerViewController {
                present(popoverController, animated: true, completion: nil)
            }
            
            
        }
    }
    
    // UIPopoverPresentationControllerDelegate inherits from UIAdaptivePresentationControllerDelegate, we will use this method to define the presentation style for popover presentation controller
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    //UIPopoverPresentationControllerDelegate
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        
    }
    
    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
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
                        
                        //수정 시 오늘 날짜로 수정
                        obj.insertDate = Date()
                        _ = insertData(obj)
                    }
                }
            }
        } catch {
            print("Error Add \(error)")
        }
        
        self.dismiss(animated: true) {
            self.delegate?.reloadTableViewData()
        }
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
