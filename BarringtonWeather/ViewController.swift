//
//  ViewController.swift
//  BarringtonWeather
//
//  Created by JScharm on 10/28/16.
//  Copyright © 2016 JScharm. All rights reserved.
//

//1. Briefly explain the purpose of your app
// The purpose of my app is to give people the weather in Barrington and a bunch of other information about it

//2. Describe the process for acquiring the API for your app.
//    To get my api key, I had to make and account on a website and request a key and once I got it I could access the API

//3. What data are your using from the API?
//  I am using a few different data points from the api. The name of the weather location, temp, dewpoint, rain, etc.

//4. How many hours did you honestly put into this project (we had roughly 12 in class hours)?
//  I started this project very very late and put in 5 in-class hours and 1 hour out of class so 6 hours total.

import UIKit
// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func <= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l <= r
  default:
    return !(rhs < lhs)
  }
}


class ViewController: UIViewController
{
    // label outlets
    @IBOutlet weak var observationTime: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var windGust: UILabel!
    @IBOutlet weak var dewpoint: UILabel!
    @IBOutlet weak var windchill: UILabel!
    @IBOutlet weak var feelsLike: UILabel!
    @IBOutlet weak var percipToday: UILabel!
    @IBOutlet weak var percipHour: UILabel!
    
    // image view outlet
    @IBOutlet weak var myImageView: UIImageView!
    
    // dictionary
  var weather = [[String: String]]()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // calling on parse function
       getWeather()
        
        
     
    }
    
        // parse function
        func parse(_ json: JSON)
        {
            // holds values
            var hold = json["current_observation"].dictionaryValue
            

            
            // gets values of object
        let time = hold["observation_time"]?.stringValue
        let tempF = hold["temp_f"]?.intValue
        let humid = hold["relative_humidity"]?.stringValue
        let windG = hold["wind_gust_mph"]?.stringValue
        let dew = hold["dewpoint_f"]?.stringValue
        let windC = hold["windchill_f"]?.stringValue
        let feelsLik = hold["feelslike_f"]?.stringValue
        let percipTD = hold["precip_today_string"]?.stringValue
        let percipH = hold["precip_1hr_string"]?.stringValue
            
            // sets labels
            observationTime.text = time
            temp.text = String(tempF!) + " " + "degrees"
            humidity.text = humid! + " " + "humidity"
            windGust.text = windG! + " mph wind gust"
            dewpoint.text = "Dewpoint " + dew! + " degrees"
            windchill.text = "Windchill " + windC! + " degrees"
            feelsLike.text = "Feels like " + feelsLik! + " degrees"
            percipToday.text = "Todays percipitation " + percipTD!
            percipHour.text = "Hourly percipitation " + percipH!
            
            
            // creates an imageView and a background color based on what the tempertature is
            if tempF >= 80
            {
                view.backgroundColor = UIColor.red
                myImageView.image = UIImage(named: "hot")
            }
            
            if tempF >= 60 && tempF <= 80
            {
                view.backgroundColor = UIColor.orange
                myImageView.image = UIImage(named: "nice")
            }
            
            if tempF >= 40 && tempF <= 60
            {
                view.backgroundColor = UIColor.lightGray
                myImageView.image = UIImage(named: "fall")
            }
            
            if tempF >= 20 && tempF <= 40
            {
                view.backgroundColor = UIColor.blue
                myImageView.image = UIImage(named: "kindaCold")
            }
            
            if tempF >= -100 && tempF <= 20
            {
                view.backgroundColor = UIColor.green
                myImageView.image = UIImage(named: "freezing")
            }
            
            
            
            
            
        }
    // if refresh button is pressed then it parses data again
    @IBAction func refresh(_ sender: AnyObject)
    {
        getWeather()
    }
    
    // parse fucntion
    func getWeather()
    {
        // points to whitehouse.govs server
        let urlString = "http://api.wunderground.com/api/f09233fa10a0c702/conditions/q/Illinois/Barrington.json"
        
        // if statement check to see if url is valid
        if let url = URL(string: urlString)
        {
            // returns data object from url, try checkd for url connection
            if let myData = try? Data(contentsOf: url, options: [])
            {
                // if data object was created, we created a json object from library
                let json = JSON(data: myData)
            
                print("parse working")
                parse(json)
            }
        }

    }
    
    
}

       
        


   


