//  FirstViewController.swift
//  New Plaza Cinemas
//
//  Created by Zvonko on 9/8/18.
//  Copyright © 2018 ZvoNik. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var eventsArray = [Item]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
        cell.textLabel?.text = self.eventsArray[indexPath.row].summary
//        cell.textLabel?.text = "\( Int(slider.value) * (indexPath.row+1))"

        return cell
    }
    
    @IBOutlet weak var listingsTableView: UITableView!
    
    let baseURL = "https://www.googleapis.com/calendar/v3/calendars/hhhirgpl00dq437bv5oqd93h40%40group.calendar.google.com/events?key="
    var finalURL = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        listingsTableView.delegate = self
        listingsTableView.dataSource = self
        
        finalURL = baseURL + APIkey
        print("finalURL: " + finalURL)
        getEvents(url: finalURL)
        
        
        //MARK: - Networking & JSON Parsing (JSONDecoder Method) - GOOGLE CALENDAR
        /***************************************************************/
        
        let myURL = URL(string: finalURL)!
        let request = URLRequest(url: myURL)
        let taskNPC = URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let theData = try decoder.decode(Welcome.self, from: data)
                print("************ Hi GOOGLE CAL via JSONDecoder!")
                print(theData)
                for index in theData.items.indices {
                    print(theData.items[index].summary)
                    print(theData.items[index].description)
                    print(theData.items[index].location)
                    print(theData.items[index].start)
//                    var item: Item?
//                    item?.summary = theData.items[index].summary
//                    item?.start = theData.items[index].start
//                    self.eventsArray.append(item!)
                }
            } catch let err {
                print("Decoding Error!(2)",err)
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
    
    //MARK: - JSON Parsing (Alamofire Method)
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

