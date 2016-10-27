//
//  MainViewController.swift
//  LocalWeather
//
//  Created by Safina Lifa on 10/27/16.
//  Copyright © 2016 Safina Lifa. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {
    
    var refresh = UIRefreshControl()
    
    @IBOutlet var weatherUpdates: UITableView!
    let apiKey = "7a8182889a67db17106dfc9c23243091"
    let defaultSession = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    var dataTask: NSURLSessionDataTask?
    var days = [Forecast]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
          refreshControl?.tintColor = UIColor.grayColor()
       // refreshControl?.attributedTitle = NSAttributedString(string: "Updating")
        self.weatherUpdates.addSubview(refresh)
        
        loadRefreshControl()
        getForecast()
    }
    func loadRefreshControl() {
        weatherUpdates.reloadData()
      
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
      
        
    }
    

    func getForecast() {
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?units=imperial&cnt=16&lat=33.749&lon=-84.387978&appid=\(apiKey)")
        
        dataTask = defaultSession.dataTaskWithURL(url!) {
            data, response, error in
            dispatch_async(dispatch_get_main_queue()) {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            }
            if let error = error {
                print(error.localizedDescription)
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    self.updateWeather(data)
                    self.refresh.endRefreshing()
                }
            }
        }
        dataTask?.resume()
    }
    
    func updateWeather(data: NSData?) {
        days.removeAll()
        
        do {
            
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: [])
            print(json)
            
            if let days = json["list"] as? [[String: AnyObject]] {
                for day in days {
                    if let weatherDay = Forecast(json: day) {
                        self.days.append(weatherDay)
                    }
                }
            }
            
        } catch let error as NSError {
            print("Error parsing results: \(error.localizedDescription)")
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            self.tableView.reloadData()
        }
    }

    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let day = days[indexPath.row]

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("data", forIndexPath: indexPath) as! Data
            let date = NSDate(timeIntervalSince1970: Double(day.date))
            cell.dateLabel.text = date.dayOfWeekString() + ", \(date.dateString())"
            cell.tempMaxLabel.text = String(day.temp.max) + "°"
            cell.tempMinLabel.text = String(day.temp.min) + "°"
            let imageName = Forecast.artNameForCode(day.iconName)
            cell.thumnailImageView.image = UIImage(named:imageName)
            cell.descriptionLabel.text = day.description
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("summaryCell", forIndexPath: indexPath) as! SummaryCell
            let date = NSDate(timeIntervalSince1970: Double(day.date))
            cell.dateLabel.text = date.dayOfWeekString()
            cell.tempMaxLabel.text = String(day.temp.max) + "°"
            cell.tempMinLabel.text = String(day.temp.min) + "°"
            let imageName = Forecast.iconNameForCode(day.iconName)
            cell.thumnailImageView.image = UIImage(named:imageName)
            cell.descriptionLabel.text = day.description
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        } else {
            return 90
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("DetailViewController", sender: self)
        refresh.endRefreshing()
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DetailViewController" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationViewController = segue.destinationViewController as! DetailViewController
                destinationViewController.day = days[indexPath.row]
            }
        }
    }
    
}

extension NSDate {
    
    func dayOfWeekString() -> String {
        var dayOfWeek:String = ""
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        if isToday() || isTomorrow() {
            formatter.doesRelativeDateFormatting = true
            formatter.dateStyle = .LongStyle
        }
        dayOfWeek = formatter.stringFromDate(self)
        return dayOfWeek
    }
    
    func dateString() -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MMMM d"
        return formatter.stringFromDate(self)
    }
    
    func isToday() -> Bool {
        return NSCalendar.currentCalendar().isDateInToday(self)
    }
    
    func isTomorrow() -> Bool {
        return NSCalendar.currentCalendar().isDateInTomorrow(self)
    }
    
}