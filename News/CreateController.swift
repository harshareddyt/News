//
//  CreateController.swift
//  News
//
//  Created by Sunny Reddy on 02/11/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//

import UIKit

class CreateController: UIViewController {
    
    var successmessage = String()

    @IBOutlet weak var NameTextField: UITextField!
    @IBOutlet weak var JobTextField: UITextField!
    @IBOutlet weak var CreateBtn: UIButton!
   
    
    @IBAction func CreateBtn(_sender: UIButton) {
//        print("clicked")
        createfunction()
    }
    
    func createfunction(){
        
        DispatchQueue.main.async {
            IJProgressView.shared.showProgressView()
        }
        guard let url = URL(string: "https://reqres.in/api/users") else { return }
        let headers = [
            "Content-Type": "application/json",
            "cache-control": "no-cache",
            //            "Postman-Token": "a670c020-5d3e-4e05-8535-5c8ad7c63eb2"
        ]
        let parameters = [
            "name": NameTextField.text!,
            "job":  JobTextField.text!]
        
        let postData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
            }
            if let data = data {
                do {
                    var status = Reach().connectionStatus()
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
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                        
                        
                        print("json:  \(json)")
                        let nameString = (json["name"] as AnyObject? as? String) ?? ""
                        if(nameString.count>0){
                            print("success")
                            
                        }
                        else{
                            print("not success")
                        }
                        
                        
                        DispatchQueue.main.async {
                            IJProgressView.shared.hideProgressView()
                        }
                        /*if(status === 201){
                            let alert = UIAlertController(title: "", message: "Thanks! Your Name has been succesfully created.", preferredStyle: .alert)
                            
                            let ok = UIAlertAction(title: "succesfully created", style: .default, handler: { action in
                                DispatchQueue.main.async {
                                    IJProgressView.shared.hideProgressView()
                                }
                                let view = self.storyboard?.instantiateViewController(withIdentifier: "HomeController") as! HomeController
                                //
                                self.present(view, animated: false,completion: nil)
                            })
                        }*/
                   
                        
                    }
                } catch {
                    
                    print(error)
                }
            }
            }
            .resume()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rechebil()
    }
    
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
