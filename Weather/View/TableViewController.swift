//
//  ViewController.swift
//  Weather
//
//  Created by Дмитрий  Ванчугов on 07.04.2022.
//

import UIKit
import CoreLocation

class TableViewController: UIViewController {
    
    let emtptyCity = Weather()
    let networkWeatherManager = NetworkWeatherManager()
    
    var nameCitiesArray = ["Москва", "Томь", "Новосибирск", "Пенза","Самара","Сочи","Ростов","Лунино","Владивосток","Стамбул"]
    var citiesArray: [Weather] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emtptyCity, count: nameCitiesArray.count)
        }
        
        addCities()
    }
    
    
    @IBAction func addButtonPress(_ sender: UIButton) {
        addCityAlert(name: "Add", placeholder: "City") { str in
            self.nameCitiesArray.append(str)
            self.citiesArray.append(self.emtptyCity)
            self.addCities()

        }
    }
    

    func addCities(){
        getCityWeather(citiesArray: nameCitiesArray) { index, weather in
            
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.nameCitiesArray[index]
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
        
}



extension TableViewController: UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    func changecolor(color: UIColor) {
        self.view.backgroundColor = color
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else {return UITableViewCell()}
        let weather = citiesArray[indexPath.row]
        cell.configure(weather: weather)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let controller = self.storyboard?.instantiateViewController(withIdentifier:"CityViewController") as? CityViewController else{return}
            
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .crossDissolve
        controller.weatherModel = citiesArray[indexPath.item]
        self.present(controller, animated: true, completion: nil)
        print(citiesArray[indexPath.item])
        
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { _, _, completionHendler in
            let editingRow = self.nameCitiesArray[indexPath.row]
            if let index = self.nameCitiesArray.firstIndex(of: editingRow){
                self.citiesArray.remove(at: index)
            }
            tableView.reloadData()
        }
       return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
   
}
