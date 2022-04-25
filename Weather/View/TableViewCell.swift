//
//  TableViewCell.swift
//  Weather
//
//  Created by Дмитрий  Ванчугов on 07.04.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    
//
//    @IBOutlet weak var nameLabel: UILabel!
//    @IBOutlet weak var conditionLabel: UILabel!
//    @IBOutlet weak var valueLabel: UILabel!
    
    func configure(weather: Weather){
        self.nameLabel.text = weather.name
        self.conditionLabel.text = weather.condition
        self.valueLabel.text = "\(weather.temperature)"
    }
    
    
    

}


