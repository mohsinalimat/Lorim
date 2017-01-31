//
//  ChatLogController.swift
//  Lorim
//
//  Created by Nikolas Andryuschenko on 1/29/17.
//  Copyright © 2017 Andryuschenko. All rights reserved.
//


import UIKit
import Firebase

class ChatLoginController: UICollectionViewController, UITextFieldDelegate{

    
    var user: User? {
        didSet {
            navigationItem.title = user?.name
        }
    }
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Message..."
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
       return textField
    }()
    
    //reference to input textfield
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Chat log controller   "
        
        collectionView?.backgroundColor = UIColor.white
        
        setupInputComponents()
        
    }
    
    
    func setupInputComponents() {
        
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
   
        
        
        view.addSubview(containerView)
    
    
        containerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(sendButton)
        
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        
        containerView.addSubview(inputTextField)
        
        inputTextField.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
        inputTextField.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
       // inputTextField.widthAnchor.constraint(equalToConstant: 100).isActive = true
        inputTextField.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        let separatorLineView = UIView()
        separatorLineView.backgroundColor = UIColor.black
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(separatorLineView)
        
        separatorLineView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        separatorLineView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        separatorLineView.widthAnchor.constraint(equalTo: containerView.widthAnchor).isActive = true
        separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        
        
    }
    
    func handleSend() {
    
        let ref = FIRDatabase.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        // generates a unique key a firebase reference representing list of items.. check description
        
        let toId = user!.id!
        let fromId = FIRAuth.auth()!.currentUser!.uid
       // let timestamp = NSDate(timeIntervalSince1970: 1415637900)
     //   let values=["text": inputTextField.text!, "toId": toId, "fromId": fromId, "timestamp": timestamp] as [String : Any]
        let values=["text": inputTextField.text!, "toId": toId, "fromId": fromId] as [String : Any]
 
        
        childRef.updateChildValues(values)
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        handleSend()
        
        return true
    }
    
    
    
    
    
    

}
