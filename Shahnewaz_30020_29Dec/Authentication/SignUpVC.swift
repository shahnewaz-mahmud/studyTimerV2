//
//  SignUpVC.swift
//  Shahnewaz_30020_29Dec
//
//  Created by Shahnewaz on 7/1/23.
//

import UIKit

class SignUpVC: UIViewController {
    
    struct User: Encodable, Decodable {
        let userId: String?
        let firstName: String
        let lastName: String
        let email: String
        let password: String
    }
    
    
    
    
    @IBOutlet weak var firstNameInput: UITextField!
    @IBOutlet weak var lastNameInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var confirmPasswordInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordInput.isSecureTextEntry = true
        confirmPasswordInput.isSecureTextEntry = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        

    }
    
    @IBAction func signUpAction(_ sender: Any) {
        
        let newUser = User(userId: nil, firstName: firstNameInput.text ?? "", lastName: lastNameInput.text ?? "", email: emailInput.text ?? "", password: passwordInput.text ?? "")
        
        guard let url = URL(string: Constants.apidomain + "users") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(newUser)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("The error was: \(error.localizedDescription)")
            } else {
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("Response json is: \(String(describing: jsonRes))")
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: Constants.segueToSignInId, sender: nil)
                }
                
                
            }

        }.resume()
        
    }
    
}
