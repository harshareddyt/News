//
//  ListDetailController.swift
//  News
//
//  Created by Sunny Reddy on 03/11/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//

import UIKit

class ListDetailController: UIViewController {
    
    var dataObject = NSObject()
    var ID = NSNumber()
    var texts: String? = nil


    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var JobTextField: UITextField!
    @IBOutlet weak var UpdateButton: UIButton!
    @IBAction func UpdateButton(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // NameTextField.text = text
        getDetails()
    }
    
    func getDetails(){
        let url:URL = URL(string: "https://reqres.in/api/users/\(texts ?? "")")!
        
        let postString = ""
        print("postString:::\(postString)")
        let postData:Data = postString.data(using: String.Encoding(rawValue: String.Encoding.ascii.rawValue))!
        let postLength:NSString = String( postData.count ) as NSString
        let request:NSMutableURLRequest = NSMutableURLRequest(url:url)
        request.httpMethod = "GET"
        request.httpBody = postData
        request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        var reponseError: NSError?
        var response: URLResponse?
        var urlData: Data?
        do {
            urlData = try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning:&response)
        } catch let error as NSError {
            reponseError = error
            urlData = nil
        }
        if ( urlData != nil ) {
            let res = response as! HTTPURLResponse!;
            print("Response code: %ld", res?.statusCode);
            if ((res?.statusCode)! >= 200 && (res?.statusCode)! < 300)
            {
                let responseData:NSString  = NSString(data:urlData!, encoding:String.Encoding.utf8.rawValue)!
                NSLog("Response ==> %@", responseData);
            }
        }
        do {
            let jsonData = try? JSONSerialization.jsonObject(with: urlData!, options: []) as! NSDictionary
           dataObject = (jsonData?.value(forKey:"data")) as! NSObject
           NameTextField.text = (dataObject.value(forKey:"first_name")) as? String
            JobTextField.text = (dataObject.value(forKey:"email")) as? String
        }
    }
}
