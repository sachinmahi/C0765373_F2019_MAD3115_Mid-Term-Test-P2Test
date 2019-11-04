//
//  LoginViewController.swift
//  C0765373_F2019_MAD3115_Mid-Term-Test-P2Test
//
//  Created by simar mahi on 04/11/19.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var email_txt: UITextField!
    
    @IBOutlet weak var password_txt: UITextField!
    
    @IBOutlet weak var loginBT: UIBarButtonItem!
    
    @IBOutlet weak var remember_Switch: UISwitch!
    
    var customerDict = [CustomersStruct]()
    
    // getting user defaults reference
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        remember_Switch.isOn = false
        getRememberMe()
        readCustomersPlistFile()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login_BTN(_ sender: UIBarButtonItem) {
        if let email = email_txt.text{
            if !email.isEmpty{
                
                if email.isVAlidEmail(){
                    if let password = password_txt.text{
                        if !password.isEmpty{
                            if password.sizeCheck(){
                                
                                if  checkEmailPassword(email: email, password: password) {
                                    setRememberMe()
                                    
                                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                    let dashboardVC = storyboard.instantiateViewController(withIdentifier: "homeVC") as! BillListTableViewController
                            
                                    self.navigationController?.pushViewController(dashboardVC, animated: true)
                                    
                                    
                                }else{
                                    showAlerBox(msg: "You have enter wrong credentials")
                                }
                                
                            }else{
                                showAlerBox(msg: "Invalid password size")
                            }
                            
                        }else{
                            showAlerBox(msg: "Please enter password")
                        }
                    }
                }
                else{
                    showAlerBox(msg: "Please enter valid email")
                }
            }else{
                 showAlerBox(msg: "Please enter useremail")
            }
        }
        
    }
    
    func showAlerBox(msg : String)  {
        let alertController = UIAlertController(title: "CustomerBillApp", message:
            msg, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    func readCustomersPlistFile(){
        
        let plist = Bundle.main.path(forResource: "customers", ofType: "plist")
        
        if let dict = NSMutableDictionary(contentsOfFile: plist!){
            if let customers = dict["customers"] as? [[String:Any]]
            {
                for customer in customers {
                    let id = customer["customerID"] as! Int
                    let firstName = customer["customerFirstName"] as! String
                    let lastName = customer["customerLastName"] as! String
                    let email = customer["email"] as! String
                    let password = customer["password"] as! String
                    
                    self.customerDict.append(CustomersStruct(customerID: id, customerFName: firstName, customerLName: lastName, email: email, password: password))
            }
        }
    }
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func checkEmailPassword(email : String , password : String) -> Bool{
        
        for everyCustomer in customerDict{
            if (everyCustomer.email == email && everyCustomer.password == password) {
                return true
            }
        }
        return false
    }
    
    func setRememberMe()  {
        if remember_Switch.isOn {
            userDefault.set(self.email_txt.text, forKey: "userEmail")
            userDefault.set(self.password_txt.text, forKey: "userPassword")
        }else{
            userDefault.set("", forKey: "userEmail")
            userDefault.set("", forKey: "userPassword")
        }
    }
    
    private func getRememberMe()
    {
        let userDefault = UserDefaults.standard
        
        if let email = userDefault.string(forKey: "userEmail")
        {
            email_txt.text = email
            
            if let password = userDefault.string(forKey: "userPassword")
            {
                password_txt.text = password
                remember_Switch.setOn(true, animated: false)
            }
        }
    }

}
