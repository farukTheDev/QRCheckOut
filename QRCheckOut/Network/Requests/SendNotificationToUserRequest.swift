//
//  SendNotificationToUserRequest.swift
//  QRCheckOut
//
//  Created by Ömer Faruk KISIK on 12.01.2022.
//

import Foundation

struct SendNotificationToUserRequest: Codable {
    var to: String
    var content_available = true
    var data: NotificationDataNode?
}

struct NotificationDataNode: Codable {
    var payment_status: Int
}
