//
//  userManager.swift
//  pocketFactory
//
//  Created by NingFangming on 4/22/18.
//  Copyright © 2018 fangming. All rights reserved.
//

import Foundation
import Alamofire



open class UserManager {
    
    open class func checkRegistration(registrationCode: String, completion: @escaping (_ error: String) -> Void) {
        var request = URLRequest(url: URL(string: serviceBase + "validate_reg_code")!)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json: [String: Any] = ["regCode": registrationCode] as [String : Any]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        request.httpBody = jsonData
        
        Alamofire.request(request).responseJSON { (response) in
            switch response.result{
            case .failure:
                completion(serviceOffline)
                
            case .success(let data):
                if let json = data as? [String : Any] {
                    completion(json["errMsg"] as! String)
                }
                else {
                    completion(serviceInternalError)
                }

            }
        }
    }
}
