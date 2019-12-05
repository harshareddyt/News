//
//  ViewController.swift
//  News
//
//  Created by Sunny Reddy on 02/11/19.
//  Copyright © 2019 Harsha Reddy. All rights reserved.
//

import UIKit

class HomeController: UIViewController {
    @IBOutlet weak var topview: UIView!
    
    @IBOutlet weak var GetAllButton: UIButton!
    @IBOutlet weak var CreateButton: UIButton!
    
    @IBAction func CreateButton(_ sender: UIButton) {
        
        let VC1 = self.storyboard?.instantiateViewController(withIdentifier: "CreateController") as! CreateController
        self.present( VC1, animated:false, completion:nil)
    }
    
    
    @IBAction func GetAllButton(_ sender: UIButton) {
        
        let VC1 = self.storyboard?.instantiateViewController(withIdentifier: "ListController") as! ListController
        self.present( VC1, animated:false, completion:nil)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

