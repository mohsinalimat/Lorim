//
//  LoginController.swift
//  Lorim
//
//  Created by Nikolas Andryuschenko on 1/10/17.
//  Copyright © 2017 Andryuschenko. All rights reserved.
//

import LBTAComponents
import FirebaseAuth
import FirebaseDatabase

class LoginController: UIViewController {
 
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let loginRegisterButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.red
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    
    func handleRegister() {
        guard let email = emailTextField.text, let password = passwordTextField.text, let name = nameTextField.text else {
            print("Form is not valid")
            return }
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (FIRUser, error) in
            
            if error != nil {
                print(error)
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            // authenticate user
            let ref = FIRDatabase.database().reference(fromURL: "https://lorim-2e7a1.firebaseio.com/")
            let usersReference = ref.child("users").child(user?.uid)
            let values = ["name": name, "email": email]
            usersReference.updateChildValues(values, withCompletionBlock: {(error, ref) in
                
                if error != nil {
                    print (error)
                }
                print("saved user successfuly into firebase db")
                
            })
            
        })
    }
    
    let nameTextField: UITextField = {
       
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    let nameSeperatorView: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let emailTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    let emailSeperatorView: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor.black
        return view
    }()
    
    let passwordTextField: UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.isSecureTextEntry = true
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    let passwordSeperatorView: UIView =  {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "me.jpg")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.blue
        
        
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        view.addSubview(profileImageView)
        
        setupLoginRegisterButton()
        setupInputsContainerView()
        setupProfileImageView()
    }
    

    

    
    func setupProfileImageView() {
        
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: inputsContainerView.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
    }
    
    func setupLoginRegisterButton() {
        
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 12).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    func setupInputsContainerView() {
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        //MARK: NameTextField constraints
        inputsContainerView.addSubview(nameTextField)
        
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
    
        //MARK: NameSeperatorView Constraints
        inputsContainerView.addSubview(nameSeperatorView)
        
        nameSeperatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        nameSeperatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeperatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameSeperatorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //MARK: emailTextField constraints
        inputsContainerView.addSubview(emailTextField)
        
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        
        //MARK: emailSeperatorView Constraints
        inputsContainerView.addSubview(emailSeperatorView)
        
        emailSeperatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailSeperatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeperatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailSeperatorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //MARK: passwordTextField constraints
        inputsContainerView.addSubview(passwordTextField)
        
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        
        //MARK: passwordSeperatorView Constraints
        inputsContainerView.addSubview(passwordSeperatorView)
        
        passwordSeperatorView.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        passwordSeperatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        passwordSeperatorView.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordSeperatorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    
}

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}
