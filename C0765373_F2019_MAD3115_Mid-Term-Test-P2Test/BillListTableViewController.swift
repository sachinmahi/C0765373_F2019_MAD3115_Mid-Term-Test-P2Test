//
//  BillListTableViewController.swift
//  C0765373_F2019_MAD3115_Mid-Term-Test-P2Test
//
//  Created by simar mahi on 04/11/19.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class BillListTableViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
   
    
    
    @IBOutlet weak var users_table: UITableView!
    
    var customerList = [CustomersStruct]()
    var customerArray = Array<Customer>()
    
    var arrayBill : [Bill] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addData()
        readCustomersPlistFile()
        self.users_table.delegate = self
        self.users_table.dataSource = self
        let button1 = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout(sender:)))
        self.navigationItem.leftBarButtonItem  = button1
        
        self.navigationItem.hidesBackButton = true
        
        self.navigationItem.title = "Home"
        // Do any additional setup after loading the view.
        
    }
    
    
    
    @objc func logout(sender:UIBarButtonItem!)
    {
        print("logout")
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
                    
                    self.customerList.append(CustomersStruct(customerID: id, customerFName: firstName, customerLName: lastName, email: email, password: password))
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return customerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "usersCell")
        
        cell?.textLabel?.text = self.customerArray[indexPath.row].fullName
        
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        
        Customer.activeCustomer.customerId = self.customerArray[indexPath.row].customerId
        Customer.activeCustomer.firstName = self.customerArray[indexPath.row].firstName
        Customer.activeCustomer.lastName = self.customerArray[indexPath.row].lastName
        Customer.activeCustomer.email = self.customerArray[indexPath.row].email
        Customer.activeCustomer.arrayBill = self.customerArray[indexPath.row].arrayBill
//         arrayBill = Customer.activeCustomer.arrayBill
//        print("asds\(arrayBill.count)")
        print(Customer.activeCustomer.TotalAmountToPay)
//        Customer.activeCustomer.TotalAmountToPay = calculateTotalBill()
//        print(calculateTotalBill())
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: "showBillVC") as! ShowBillDetailsViewController
        
        self.navigationController?.pushViewController(dashboardVC, animated: true)
        
        
    }
    func calculateTotalBill() -> Float {
        var bill = 00.00
       print(arrayBill.count)
        for a in arrayBill{
            bill = bill + Double(a.totalBillAmount)
        }
        return Float(bill)
    }
    func addData(){
 
        let b1: Mobile = Mobile(Id: 1, billDate: Date(), billType: billTypes.Mobile, totalBillAmount: 74.52, mobileManufacturer: "Samsung S10", planName: "Talk + Data", mobileNumber: "+12345678901", internetUsed: 23, minuteUsed: 34)
        
        
        //Creating Customer Objects
        
        let cust1: Customer = Customer(customerId: 1, firstName: "sachin", lastName: "mahi", email: "sachin@gmail.com",arrayOfBills: [b1,b2])
         print(cust1.arrayBill.count)
        
        
        customerArray = [cust1]
    }
}
