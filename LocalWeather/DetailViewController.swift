//
//  DetailViewController.swift
//  LocalWeather
//
//  Created by Safina Lifa on 10/27/16.
//  Copyright © 2016 Safina Lifa. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var dayLbl: UILabel!
    @IBOutlet var dateLbl: UILabel!
    @IBOutlet var tempMaxLbl: UILabel!
    @IBOutlet var tempMinLbl: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var descriptLbl: UILabel!
    @IBOutlet var humidityLbl: UILabel!
    @IBOutlet var pressureLbl: UILabel!
    @IBOutlet var windLbl: UILabel!
    
    var day:Forecast!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let date = NSDate(timeIntervalSince1970: Double(day.date))
        dayLbl.text = date.dayOfWeekString()
        dateLbl.text = date.dateString()
        tempMaxLbl.text = String(day.temp.max) + "°"
        tempMinLbl.text = String(day.temp.min) + "°"
        let imageName = Forecast.artNameForCode(day.iconName)
        imageView.image = UIImage(named:imageName)
        descriptLbl.text = day.descript
        
        humidityLbl.text = "Humidity: \(day.humid) %"
        pressureLbl.text = "Pressure: \(day.pressure) hPa"
        windLbl.text = "Wind: \(day.wind.speed) km/h \(Forecast.directionFromAngle(Int(day.wind.angle)))"
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}
