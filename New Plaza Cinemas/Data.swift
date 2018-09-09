//
//  Data.swift
//  New Plaza Cinemas
//
//  Created by Zvonko on 9/9/18.
//  Copyright © 2018 ZvoNik. All rights reserved.
//

import Foundation

struct MyData: Codable {
    let title: String?
    let date: String?
    let event_id: String?
}

//struct MyDataNPC : Codable {
//
//    struct Items : Codable {
//        let summary : String?
//        let description : String?
//        let location : String?
//        //    let start : [Date?]
//    }
//
//    var items : Items

struct Welcome: Codable {
    let kind, etag, summary, description: String
    let updated, timeZone, accessRole: String
    let nextSyncToken: String
    let items: [Item]
}

struct Item: Codable {
    let kind, etag, id, status: String
    let htmlLink, created, updated, summary: String
    let description, location: String
    let creator: Creator
    let start, end: End
    let iCalUID: String
    let sequence: Int
}

struct Creator: Codable {
    let email, displayName: String
}

struct End: Codable {
    let dateTime: String
}
