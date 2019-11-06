//
//  ShowBillDetailsViewController.swift
//  C0765373_F2019_MAD3115_Mid-Term-Test-P2Test
//
//  Created by simar mahi on 06/11/19.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

import UIKit

class ShowBillDetailsViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var customerID_txt: UILabel!
    
    @IBOutlet weak var customeName_txt: UILabel!
    
    @IBOutlet weak var customerEmail_txt: UILabel!
    
    @IBOutlet weak var allBills_table: UITableView!
    @IBOutlet weak var totalBill_txt: UILabel!
    
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.allBills_table.delegate = self
        self.allBills_table.dataSource = self
        

        self.navigationItem.backBarButtonItem?.title = "Back"

        
        let button1 = UIBarButtonItem(title: "Add Bill", style: .plain, target: self, action: #selector(addBill(sender:)))
        self.navigationItem.rightBarButtonItem  = button1
        
    
        
        self.navigationItem.title = "Bill Details"
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.customerID_txt.text = ("Customer Id : \(Customer.activeCustomer.customerId.convertToString())")
        self.customeName_txt.text = ("Customer Name : \(Customer.activeCustomer.fullName)")
        self.customerEmail_txt.text = ("Customer Email : \( Customer.activeCustomer.email)")
       
        self.totalBill_txt.text = ("Total billl to pay : \( Customer.activeCustomer.TotalAmountToPay)")
        
    }
    
    @objc func addBill(sender:UIBarButtonItem!)
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let dashboardVC = storyboard.instantiateViewController(withIdentifier: "addBillVC") as! AddNewBillViewController
        
        self.navigationController?.pushViewController(dashboardVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
 return Customer.activeCustomer.arrayBill.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "billCell")  as! UITableViewCell
        
        let currentbill = Customer.activeCustomer.arrayBill[indexPath.row]
        
        
        var furtherDetails = ""
        
        if currentbill is Mobile{
            cell.textLabel?.numberOfLines = 12
            let mobileBill = currentbill as! Mobile
            furtherDetails = "\nManufacturer Name : \(mobileBill.mobileManufacturer) \nPlan Name : \(mobileBill.planName) \nMobile Number : \(mobileBill.mobileNumber) \nInternet used : \(mobileBill.internetUsed.internetUnit()) \nMinutes Used : \(mobileBill.minuteUsed.minutesUnits()) "
            
            
        }else if currentbill is Hydro{
           cell.textLabel?.numberOfLines = 12
            let hydroBill = currentbill as! Hydro
            furtherDetails = "Agency Name : \(hydroBill.agencyName) \nUnit Consumed : \(hydroBill.unitconsumed.UnitHyrdoConvert())"
             print(furtherDetails)
        }
        else{
            cell.textLabel?.numberOfLines = 12
            let internetBill = currentbill as! Internet
            furtherDetails = "Provider Name : \(internetBill.providerName) \nInternet Used : \(internetBill.internetUsed.internetUnit())"
        }
        
        cell.textLabel?.text = "Bill ID : \(String(describing: currentbill.Id)) \nBill Date : \(String(describing: currentbill.billDate.getForamttedDate())) \nBill Type : \(String(describing: currentbill.billType)) \nBill Total : \(String(describing: currentbill.totalBillAmount)) \(furtherDetails)"
        
        return cell
       
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
