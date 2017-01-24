//
//  ViewController.swift
//  Lorim
//
//  Created by Nikolas Andryuschenko on 1/10/17.
//  Copyright © 2017 Andryuschenko. All rights reserved.
//


import UIKit
import Firebase

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    }
    
    func handleLogout() {
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
        
    }
}
