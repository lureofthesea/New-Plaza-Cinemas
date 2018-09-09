//  FirstViewController.swift
//  New Plaza Cinemas
//
//  Created by Zvonko on 9/8/18.
//  Copyright © 2018 ZvoNik. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController {

    let baseURL = "https://www.googleapis.com/calendar/v3/calendars/hhhirgpl00dq437bv5oqd93h40%40group.calendar.google.com/events?key="
    var finalURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        finalURL = baseURL + APIkey
        print("finalURL: " + finalURL)
        getEvents(url: finalURL)
        
        //MARK: - Networking (JSONDecoder Method) - FREE EVENTS
        /***************************************************************/
        
        var myURL = URL(string: "https://data.cityofnewyork.us/resource/jxsh-uewe.json?&date=2013-09-10")!

        var request = URLRequest(url: myURL)
//        let task = URLSession.shared.dataTask(with: request) {
//            data, response, error in
//            guard let data = data else { return }
//            do {
//                let decoder = JSONDecoder()
//                let theData = try decoder.decode([MyData].self, from: data)
//                print("****************** Hi FREE EVENTS!")
//                print(theData)
//                for index in theData.indices {
//                    print(theData[index].title!)
//                }
//            } catch let err {
//                print("Err!(1)",err)
//            }
//
//        }
//        task.resume()
        
        
        //MARK: - Networking (JSONDecoder Method) - GOOGLE CALENDAR
        /***************************************************************/
        
        myURL = URL(string: finalURL)!

        request = URLRequest(url: myURL)
        let taskNPC = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let theData = try decoder.decode(Welcome.self, from: data)
                print("****************** Hi GOOGLE CAL!")
                print(theData)
                for index in theData.items.indices {
                    print(theData.items[index].summary)
                    print(theData.items[index].description)
                    print(theData.items[index].location)
                    print(theData.items[index].start)
                }
            } catch let err {
                print("Err!(2)",err)
            }
            
        }
        taskNPC.resume()
        
    }
    
    //MARK: - Networking (Alamofire Method)
    /***************************************************************/
    
    func getEvents(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Success! Got the calendar events with Alamofire")
                    let eventsJSON : JSON = JSON(response.result.value!)
                    
                    self.updateEvents(json: eventsJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
//                    self.bitcoinPriceLabel.text = "Connection Issues"
                }
        }
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    
    func updateEvents(json : JSON) {
        
        if let eventsResult = json["items"][0]["summary"].string {
//            bitcoinPriceLabel.text = symbol + String(eventsResult)
            print(eventsResult)
        } else {
            print("structure not found :((((((")
            print(json)
        }
    }
    
}

