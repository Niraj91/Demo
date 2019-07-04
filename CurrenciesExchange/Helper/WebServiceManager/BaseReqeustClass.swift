//
//  BaseReqeustClass.swift
//  CurrenciesExchange
//
//  Created by Apple on 30/06/19.
//  Copyright © 2019 Niraj. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

enum apiName: String {
    case experiences = "experiences.json"
    case none = ""
}

//Live URL
enum apiURL: String {
    case s3URL = "https://s3.amazonaws.com/staticfiles.popguide.me/code_challenge/exp/"
    case apilayerURL = "http://www.apilayer.net/api/live?access_key=e3ceabbf4f6ad1018e7f3cd858bc8aad&format=1"
    case currencieList = "http://www.apilayer.net/api/list?access_key=e3ceabbf4f6ad1018e7f3cd858bc8aad&format=1"
}

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}

class BaseReqeustClass:NSObject {
    
    let alamofireManager: Alamofire.SessionManager

    override init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 6000
        configuration.timeoutIntervalForResource = 6000 // seconds
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    //GET method
    class func GETRequset<T: BaseMappable>(apiName:apiName, url:apiURL, showLoader: Bool, responseModel: Mapper<T>, success:(( AnyObject ) -> Void)?)
    {
        if !Connectivity.isConnectedToInternet  {
            BaseReqeustClass.showAlert(message: "Please check your internet connection and try again.")
            return
        }
        
        if(showLoader) {
            appDelegate.showLoader()
        }
        print(url.rawValue + apiName.rawValue)
        
        Alamofire.request(url.rawValue + apiName.rawValue, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HeaderClass.objHeaderClass.HeaderDictionary).responseJSON { (response:DataResponse<Any>) in
            
            switch(response.result) {
            case .success(_):
                if response.result.value != nil{
                    print(response.result.value!)
                    BaseReqeustClass.HandleResponse(model: responseModel,apiResponse: response , successHandler: { (object) -> Void in
                        success!(object as AnyObject)
                    })
                }
                break
                
            case .failure(_):
                appDelegate.hideLoader()
                print(response.result.error!)
                break
            }
        }
    }
    
    //Success Response Handle
    class func HandleResponse<T: BaseMappable>(model: Mapper<T>, apiResponse: DataResponse<Any>, successHandler: ((AnyObject)-> Void)) {
        if let JSON = apiResponse.result.value {
            print("JSON: \(JSON)")
            appDelegate.hideLoader()

            let dataObject = model.map(JSON: JSON as! [String: Any])!
            successHandler(dataObject as AnyObject)
        }
    }
    
    class func showAlert(message:String) -> Void {
        let alertController = UIAlertController(title: kAppName, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { _ in
            
        }))
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
