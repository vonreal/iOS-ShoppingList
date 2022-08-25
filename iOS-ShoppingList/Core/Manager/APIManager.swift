//
//  APIManager.swift
//  iOS-ShoppingList
//
//  Created by 나지운 on 2022/08/26.
//

import Foundation

import Alamofire
import SwiftyJSON

class APIManager {
    private init() {}
    
    static let shared = APIManager()
    
    func requestUnsplashAPI(page: Int, text: String, Handler: @escaping (Int, [String]) -> ()) {
        let url = EndPoint.unsplash + "?page=\(page)&query=\(text)&client_id=\(APIKey.unsplashAccessKey)"
        
        AF.request(url, method: .get)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let jsonArray = json["results"].arrayValue
                    let total = json["total"].intValue
                    var photos = [String]()
                    
                    for json in jsonArray {
                        let thumbURL = json["urls"]["thumb"].stringValue
                        photos.append(thumbURL)
                    }
                    Handler(total, photos)
                    
                case .failure(let error):
                    print(error)
                    break
                }
            }
    }
}
