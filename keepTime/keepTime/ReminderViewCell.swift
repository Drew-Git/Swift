//
//  ReminderViewCell.swift
//  keepTime
//
//  Created by 김선종 on 2020/10/25.
//  Copyright © 2020 drewVvv. All rights reserved.
//

import UIKit

class ReminderViewCell : UITableViewCell {
    
    var seqCell: Int!
    @IBOutlet weak var tagCell: CustomTagView!
    @IBOutlet weak var contentsCell: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var endDateCell: UILabel!
    @IBOutlet weak var progressViewCell: CustomerProgressView!
    @IBOutlet weak var passDayCell: CustomDateLabel!
    @IBOutlet weak var deleteBtnCell: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.hideDeleteBtn()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        self.hideDeleteBtn()
    }

//    func hideDeleteBtn() {
//        deleteBtnCell.isHidden = true
//    }
    func showDeleteBtn() {
        deleteBtnCell.isHidden = false
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
