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

struct Welcome: Codable {
    let kind, etag, summary, description: String
    let updated, timeZone, accessRole: String
    let nextSyncToken: String
    let items: [Item]
}

struct Item: Codable {
    let kind, etag, id, status: String
    var htmlLink, created, updated, summary: String
    var description, location: String
    let creator: Creator
    var start, end: DateTime
    let iCalUID: String
    let sequence: Int
}

struct Creator: Codable {
    let email, displayName: String
}

struct DateTime: Codable {
    let dateTime: String
}
