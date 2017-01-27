//
//  NewMessageController.swift
//  Lorim
//
//  Created by Nikolas Andryuschenko on 1/26/17.
//  Copyright © 2017 Andryuschenko. All rights reserved.
//

import UIKit
import Firebase


class NewMessageController: UITableViewController {

    let cellId = "cellId"
    
    //holds reference to value in user class
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cance", style: .plain, target: self, action: #selector(handleCancel))
        
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        
        fetchUser()
    }
    
    //takes the information and prints data from firebase
    func fetchUser() {
        
        
        FIRDatabase.database().reference().child("users").observeSingleEvent(of: .childAdded, with: { (snapshot) in
        
            
            if let dictionary = snapshot.value as? [String:AnyObject] {
                let user = User()
                
                // if you use this setter, your app will crash if your class properties don't exactly match up with the firebase dictionary keys
                user.setValuesForKeys(dictionary)
                self.users.append(user)
                
                
                // this will crash because of background thread, so lets use dispatch_async to fix this
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
                //user.name = dictionary["name"]
                
            }
        })
    }
    
    func handleCancel() {
        dismiss(animated: true, completion: nil)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //using a hack for now.. need to deque our cells for memory efficiency
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
    
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        return cell
    }
    
   }


//custom cell
class UserCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier:reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


