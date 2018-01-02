//
//  CityCell.swift
//  Weather
//
//  Created by apple on 2017/12/5.
//  Copyright © 2017年 nju. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
    //Properties

    @IBOutlet weak var CityWeather: UIImageView!
    @IBOutlet weak var CityInfo: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
