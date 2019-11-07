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
 
        let b1: Mobile = Mobile(Id: 1, billDate: Date(), billType: billTypes.Mobile, totalBillAmount: 84.82, mobileManufacturer: "Apple iPhone 8", planName: "Talk + Data", mobileNumber: "+16477848654", internetUsed: 55, minuteUsed: 54)
        let b2: Mobile = Mobile(Id: 2, billDate: Date(), billType: billTypes.Mobile, totalBillAmount: 56.90, mobileManufacturer: "Samsung", planName: "LTE+3G 8GB Promo plan", mobileNumber: "+1986764285", internetUsed: 65, minuteUsed: 766)
        
        let b3: Internet = Internet(Id: 1, billDate: Date(), billType: billTypes.Internet, totalBillAmount: 25.89, providerName: "Bell", internetUsed: 44)
        
        let b4: Internet = Internet(Id: 2, billDate: Date(), billType: billTypes.Internet, totalBillAmount: 255.89, providerName: "Rogers", internetUsed: 707)
        
        let b5: Hydro = Hydro(Id: 1, billDate: Date(), billType: billTypes.Hydro, totalBillAmount: 895.50, agencyName: "Sun Energy", unitconsumed: 66)
        
        let b6: Hydro = Hydro(Id: 2, billDate: Date(), billType: billTypes.Hydro, totalBillAmount: 476.8, agencyName: "Energizer", unitconsumed: 98)
        
        //Creating Customer Objects
        
        let cust1: Customer = Customer(customerId: 1, firstName: "sachin", lastName: "mahi", email: "sachin@gmail.com",arrayOfBills: [b1,b2])
         print(cust1.arrayBill.count)

        let cust2: Customer = Customer(customerId: 2, firstName: "simranjit", lastName: "singh", email: "simranjit@gmail.com",arrayOfBills: [b2,b3])
        

        let cust3: Customer = Customer(customerId: 3, firstName: "harmanpreet", lastName: "singh", email: "harmanpreet@gmail.com",arrayOfBills: [b4,b3])
        
        
        
        let cust4: Customer = Customer(customerId: 4, firstName: "varinder", lastName: "Dhillon", email: "varinder@gmail.com",arrayOfBills: [b4,b5])
    
        
        
        let cust5: Customer = Customer(customerId: 5, firstName: "charanpreet", lastName: "kaur", email: "charan@gmail.com",arrayOfBills: [b1,b3])
        
        
        customerArray = [cust1, cust2, cust3, cust4, cust5]
        
    }
}
