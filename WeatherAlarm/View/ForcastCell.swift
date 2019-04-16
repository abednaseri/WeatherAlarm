//
//  ForcastCell.swift
//  WeatherAlarm
//
//  Created by Abed on 15.04.19.
//  Copyright © 2019 Webiaturist. All rights reserved.
//

import UIKit

class ForcastCell: UITableViewCell {

    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
