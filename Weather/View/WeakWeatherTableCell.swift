//
//  WeakWeatherTableCell.swift
//  Weather
//
//  Created by Дмитрий  Ванчугов on 15.04.2022.
//

import UIKit

class WeakWeatherTableCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    func configure (first: String, second: Int, third: Int){
        dayLabel.text = first
        minTempLabel.text = "\(second)"
        maxTempLabel.text = "\(third)"
    }
}
