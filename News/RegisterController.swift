//
//  RegisterController.swift
//  News
//
//  Created by Sunny Reddy on 21/11/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    
    @IBOutlet weak var usernametextfield: UITextField!
    @IBOutlet weak var passwordtextfield: UITextField!
    @IBAction func RegisterButton(_ sender: UIButton) {
        signup()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    func signup(){
        
        
        
        
            
            
            
            
            
            
            let url:URL = URL(string: "https://reqres.in/api/register")!
            
            let postString = "email=\(usernametextfield.text!)&password=\(passwordtextfield.text!)"
            
            let postData:Data = postString.data(using: String.Encoding(rawValue: String.Encoding.ascii.rawValue))!
            
            let postLength:NSString = String( postData.count ) as NSString
            
            let request:NSMutableURLRequest = NSMutableURLRequest(url:url)
            request.httpMethod = "POST"
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
                
                print("Success: %ld", jsonData);
                
                let dataString = (jsonData?.value(forKey:"id")) as! NSNumber
                print("dataString:\(dataString)")
                
                let sucess = (jsonData?.value(forKey:"token")) as! NSString
                
                print("sucess:\(sucess)")
                let view = self.storyboard?.instantiateViewController(withIdentifier:
                    "LoginController") as! LoginController
                self.present( view, animated:false, completion:nil)
                
                
        }
        
        /*
         
         let jsonData = try? JSONSerialization.jsonObject(with: urlData!, options: []) as! NSDictionary
         
         print("Success: %ld", jsonData);
         
         let dataString = (jsonData?.value(forKey:"info")) as! NSDictionary
         print("dataString:\(dataString)")
         
         let sucess = (dataString.value(forKey:"errormessage")) as! NSString
         
 */
    }

//        DispatchQueue.main.async {
//            IJProgressView.shared.showProgressView()
//        }
//
//        guard let url = URL(string: "https://reqres.in/api/register") else { return }
//        let headers = [
//            "Content-Type": "application/json",
//            "cache-control": "no-cache",
//            //            "Postman-Token": "a670c020-5d3e-4e05-8535-5c8ad7c63eb2"
//        ]
//        let parameters = ["email": usernametextfield.text!,
//                          "password": passwordtextfield.text!]
//        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.allHTTPHeaderFields = headers
//        request.httpBody = postData as Data
//
//        let session = URLSession.shared
//        session.dataTask(with: request) { (data, response, error) in
//            if let response = response {
//                //print(response)
//            }
//            //  print("parameter:\(parameters)")
//            if let data = data {
//                do {
//                    let status = Reach().connectionStatus()
//                    switch status {
//                    case .unknown, .offline:
//                        print("Not connected")
//
//                        let alert = UIAlertController(title: "", message: "No Internet Connection", preferredStyle: .alert)
//                        let ok = UIAlertAction(title: "Try Again", style: .default, handler: { action in
//                            self.rechebil()
//                        })
//                        alert.addAction(ok)
//                        DispatchQueue.main.async(execute: {
//                            self.present(alert, animated: true)
//                        })
//                    case .online(.wwan):
//                        print("Connected via WWAN")
//                    case .online(.wiFi):
//                        print("Connected via WiFi")
//
//
//
//                        let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
//                        let token = (jsonData?.value(forKey:"token")) as! NSString
//
//
//
//                        let jsonmessage  = ((json as AnyObject).value(forKey:"info") as! NSDictionary)
//
//                        let datasstring  = jsonmessage.value(forKey: "res") as! NSDictionary
//
//                        self.successmessage = datasstring.value(forKey: "errormessage") as! String
//
//                    }
//                } catch {
//                    print(error)
//                }
//            }
//            }
//            .resume()
//    }
    
    func rechebil()
    {
        let status = Reach().connectionStatus()
        switch status {
        case .unknown, .offline:
            print("Not connected")
            let alert = UIAlertController(title: "", message: "No Internet Connection", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Try Again", style: .default, handler: { action in
                self.rechebil()
            })
            alert.addAction(ok)
            DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
            })
        case .online(.wwan):
            print("Connected via WWAN")
        case .online(.wiFi):
            print("Connected via WiFi")
        }
    }




}
