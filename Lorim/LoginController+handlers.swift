//
//  LoginController+handlers.swift
//  Lorim
//
//  Created by Nikolas Andryuschenko on 1/27/17.
//  Copyright © 2017 Andryuschenko. All rights reserved.
//

import UIKit
import Firebase

extension LoginController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //cannot do this in extension
   // var messagesController: MessagesController?
    
    
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is not valid")
            return
        }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user: FIRUser?, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            //successfully authenticated user
            let imageName = NSUUID().uuidString
            let storageRef = FIRStorage.storage().reference().child("profile_images").child("\(imageName).jpg")
            
            if let profileImage = self.profileImageView.image, let uploadData = UIImageJPEGRepresentation(profileImage, 0.1) {
                
                //            if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!) {
                
                storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    
                    if error != nil {
                        print(error)
                        return
                    }
                    
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                        
                        let values = ["name": name, "email": email, "profileImageUrl": profileImageUrl]
                        
                        self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                    }
                })
            }
        })
    }
    
        private func registerUserIntoDatabaseWithUID(uid: String, values: [String: AnyObject]) {
        //successfully authenticated user
        let ref = FIRDatabase.database().reference(fromURL: "https://lorim-2e7a1.firebaseio.com/")
        let usersReference = ref.child("users").child(uid)
        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
            
            if err != nil {
                print(err)
                return
            }
            
            //self.messagesController?.fetchUserAndSetupNavBarTitle()
            
          //  self.messagesController?.navigationItem.title = values["name"] as? String
            
            let user = User()
            
            user.setValuesForKeys(values)
            
            self.messagesController?.setupNavBarWithUser(user)
            
            self.dismiss(animated: true, completion: nil)
        })
        
    }
    
    func handleSelectProfileImageView() {
     
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
    
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        //capturing image
        var selectedImageFromPicker: UIImage?
        
        
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
        selectedImageFromPicker = editedImage
        }
        
        if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
        selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            profileImageView.image = selectedImage
        }
        
        dismiss(animated: true, completion: nil)
        
        
    } 
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        dismiss(animated: true, completion: nil)
    }
    
}
