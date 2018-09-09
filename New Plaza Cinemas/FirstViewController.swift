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
    }
    
    //MARK: - Networking
    /***************************************************************/
    
    func getEvents(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Sucess! Got the calendar events")
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
        
        if let eventsResult = json["averages"]["day"].double {
//            bitcoinPriceLabel.text = symbol + String(eventsResult)
            print(eventsResult)
        } else {
            print("not found :(")
        }
    }
    
}

