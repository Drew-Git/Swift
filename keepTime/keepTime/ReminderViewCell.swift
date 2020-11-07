//
//  ReminderViewCell.swift
//  keepTime
//
//  Created by 김선종 on 2020/10/25.
//  Copyright © 2020 drewVvv. All rights reserved.
//

import UIKit

class ReminderViewCell : UITableViewCell {
    
    @IBOutlet weak var tagCell: CustomTagView!
    @IBOutlet weak var contentsCell: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var endDateCell: UILabel!
    @IBOutlet weak var progressViewCell: CustomerProgressView!
    @IBOutlet weak var passDayCell: CustomDateLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
