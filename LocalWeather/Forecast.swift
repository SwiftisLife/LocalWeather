//
//  Forecast.swift
//  LocalWeather
//
//  Created by Safina Lifa on 10/27/16.
//  Copyright © 2016 Safina Lifa. All rights reserved.
//

struct Forecast {
    
    let date:Int
    let temp: (min:Int, max:Int)
    let iconName:String
    let descript:String
    let humid:Int // percentage
    let pressure:Int // hPA
    let wind: (speed: Float, angle: Int)  // km/h NW (for example)
    
    init?(json: [String: AnyObject]) {
        guard let date = json["dt"] as? Int,
            
            let temp = json["temp"] as? [String: AnyObject],
            let tempMin = temp["min"] as? Int,
            let tempMax = temp["max"] as? Int,
            
            let weather = json["weather"] as? [[String: AnyObject]],
            let iconName = weather[0]["icon"] as? String,
            let descript = weather[0]["main"] as? String,
            
            let humid = json["humidity"] as? Int,
            let pressure = json["pressure"] as? Int,
            
            let windSpeed = json["speed"] as? Float,
            let windAngle = json["deg"] as? Int
            
            else {
                return nil
        }
        
        self.temp = (tempMin,tempMax)
        self.date = date
        self.iconName = iconName
        self.descript = descript
        self.humid = humid
        self.pressure = pressure
        self.wind = (windSpeed,windAngle)
        
    }
    
    static func directionFromAngle(angle:Int) -> String {
        let directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"]
        let index:Int = ((angle + 22) / 45) % directions.count
        return directions[index]
    }
    
    static func artNameForCode(code: String) -> String {
        let digits = code.substringToIndex(code.startIndex.advancedBy(2))
        return "art_" + iconTypeForCode(digits)
    }
    
    static func iconNameForCode(code: String) -> String {
        let digits = code.substringToIndex(code.startIndex.advancedBy(2))
        return "ic_" + iconTypeForCode(digits)
    }
    
    static func iconTypeForCode(code: String) -> String {
        var name:String
        switch code {
        case "01":
            name = "clear"
        case "02":
            name = "light_clouds"
        case "03", "04":
            name = "clouds"
        case "09":
            name = "light_rain"
        case "10":
            name = "rain"
        case "11":
            name = "storm"
        case "13":
            name = "snow"
        case "50":
            name = "fog"
        default:
            name = ""
        }
        return name
    }
    
}