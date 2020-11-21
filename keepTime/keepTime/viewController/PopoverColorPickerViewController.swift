//
//  PopoverColorPickerViewController.swift
//  keepTime
//
//  Created by 김선종 on 2020/11/14.
//  Copyright © 2020 drewVvv. All rights reserved.
//

import UIKit

class PopoverColorPickerViewController: UIViewController {

    @IBOutlet weak var colorPicker: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    @IBAction func getColorTagBtnAction(_ sender: UIButton) {
        print(#file, #function, "sender.tag", sender.tag)
        print(sender.tag)
        print(sender.backgroundColor)
        print(sender.backgroundColor?.cgColor)
        print(sender.backgroundColor?.ciColor)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
