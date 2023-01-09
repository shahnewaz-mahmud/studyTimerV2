//
//  SignInVC.swift
//  Shahnewaz_30020_29Dec
//
//  Created by Shahnewaz on 7/1/23.
//

import UIKit

class SignInVC: UIViewController {
    
    struct LoginInput: Codable{
        let email: String
        let password: String
    }
    
    struct LoginResponse: Encodable, Decodable{
        let message: String
        let userId: String
        let token: String
    }

    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    
    var isPassSaved = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordInput.isSecureTextEntry = true
        self.navigationItem.setHidesBackButton(true, animated: true)
        emailInput.addTarget(self, action: #selector(getSavedPass), for: .editingChanged)
        isPassSaved = false
        
        print("Total Data",StudyTaskModel.studyTasks.count)
    }
    
    
    
    @objc func getSavedPass()
    {
        let password = Keychain().getSavedData(account: emailInput.text ?? "", service: "password")
        passwordInput.text = password
        
        if(password.count > 0){
            print(password)
            self.isPassSaved = true
        } else{
            self.isPassSaved = false
        }
       
    }

    
    @IBAction func signInAction(_ sender: Any) {
        
        guard let email = emailInput.text, let password = passwordInput.text else
        {
            return
        }
        

        let alertVC = UIAlertController(title: "Save Password?", message: "", preferredStyle: .actionSheet)
        
        let savePass = UIAlertAction(title: "Save", style: .default){_ in
            Keychain().saveData(account: email, service: "password", data: password)
            self.logIn(email: email, password: password)
            
        }
        
        let cancelAlert = UIAlertAction(title: "Cancel", style: .default){_ in
            self.logIn(email: email, password: password)
            alertVC.dismiss(animated: true)
        }
 
        alertVC.addAction(savePass)
        alertVC.addAction(cancelAlert)
        
        print(isPassSaved)

        if(email != "" && password != "" && !isPassSaved){
            self.present(alertVC, animated: true)
        } else if(isPassSaved) {
            self.logIn(email: email, password: password)
        }
        
            
    
    }
    
    
    func logIn(email: String, password: String)
    {
        let loginInput = LoginInput(email: email, password: password)
        
        guard let url = URL(string: Constants.apidomain + "login") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(loginInput)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("The error was: \(error.localizedDescription)")
            } else {
                let jsonRes = try! JSONDecoder().decode(LoginResponse.self, from: data!)
                print("Response json is: \(jsonRes.token)")
                
                Keychain().saveData(account: email, service: "token", data: jsonRes.token)
                print(Keychain().getSavedData(account: email, service: "token"))
                
                let logInInfo: [String : Any] = [Constants.pListUserId : jsonRes.userId, Constants.pListIsLoggedIn : true]
                PlistHelper().saveData(with: logInInfo)
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: Constants.segueToHomePage, sender: nil)
                }
            }

        }.resume()
    }
    
  

    
}
