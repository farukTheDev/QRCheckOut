//
//  NetworkUtils.swift
//  QRCheckOut
//
//  Created by Ömer Faruk KISIK on 12.01.2022.
//

import Foundation
import Alamofire

class NetworkUtils {
    
    static var headers: HTTPHeaders = [
        "Accept": "application/json",
        "Authorization": "key=AAAAmuGZ3HY:APA91bE_kWak0yzvIfnzIPZKRUyuLiCWaZ27kAmc2iLIxivRdhv15fZ3aLsM6SozpCLdmxXYUw-zbRPZntqlII0yYJJgKfCcS2bscqLh-9w2HFNvIEcRnej7dXRfNRm0HM-WTVm7cw1H"
    ]
    
    
    static func sendPaymentNotification(request: SendNotificationToUserRequest,
                                        completionHandler: @escaping(_ result: Bool,
                                                                     _ error: String?) -> Void){
        AF.request("https://fcm.googleapis.com/fcm/send",
                   method: .post,
                   parameters: request,
                   encoder: JSONParameterEncoder.default,
                   headers: headers).responseJSON { response in
                    debugPrint(response)
                    
                    switch response.result {
                    case .success(_):
                        completionHandler(true, nil)
                    case .failure(let error):
                        print("Request Error -> \(error)")
                        completionHandler(false, "\(error)")
                    }
                    
                   }
    }
    
}
