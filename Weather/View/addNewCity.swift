//
//  addNewCity.swift
//  Weather
//
//  Created by Дмитрий  Ванчугов on 15.04.2022.
//

import Foundation
import UIKit

extension UIViewController{
    func addCityAlert(name: String, placeholder: String, competionHandler: @escaping(String) -> ()){
        let alert = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "Ok", style: .default) { action in
            let tftext = alert.textFields?.first
            guard let text = tftext?.text else {return}
            competionHandler(text)
        }
        
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField { tf in
            tf.placeholder = placeholder
        }
        
        
        
        alert.addAction(alertOk)
        alert.addAction(alertCancel)
        present(alert, animated: true)
    }
}
