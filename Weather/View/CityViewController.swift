//
//  CityViewController.swift
//  Weather
//
//  Created by Дмитрий  Ванчугов on 07.04.2022.
//

import UIKit

class CityViewController: UIViewController {
    
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var cityConditionLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    var weatherModel: Weather?
    var a = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        refreshLabel()
    }
    
    func refreshLabel(){
        guard let weather = weatherModel else {return}
        imageView.image = UIImage(named: weather.condition)
        cityNameLabel.text = weather.name
        cityConditionLabel.text = weather.condition
        tempLabel.text = "\(weather.temperature)C"
        pressureLabel.text = "\(weather.pressureMm)mm"
        windSpeedLabel.text = "\(weather.windSpeed)m/s"
        humidityLabel.text = "\(weather.humidity)%"
        
      

        
        }
        
    func getWeekDay(number: Int)->String{
        switch number{
        case 1: return "Воскресенье"
        case 2: return "Понедельник"
        case 3: return "Вторник"
        case 4: return "Среда"
        case 5: return "Четверг"
        case 6: return "Пятница"
        case 7: return "Суббота"
        default: return ""
        }
    }
        
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    

}


extension CityViewController: UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let weather = weatherModel?.temp else{return 0}
                return weather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let weather = weatherModel?.temp[indexPath.row],
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeakWeatherTableCell", for: indexPath) as? WeakWeatherTableCell
        else {return UITableViewCell()}
        
        let date = weather.0
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let newdate = dateFormatter.date(from: date) {
        let weekday = Calendar.current.component(.weekday, from: newdate)
            cell.configure(first: getWeekDay(number: weekday) , second: weather.1, third: weather.2)

        }
        
        
        return cell
        
    }
    
  
    }
   
