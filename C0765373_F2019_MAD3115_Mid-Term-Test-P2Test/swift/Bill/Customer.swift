

import Foundation


class Customer
{
    static var activeCustomer = Customer()
    var customerId : Int
    var firstName : String
    var lastName: String
    
    var arrayBill : [Bill]
    
    var fullName: String // computed variable
    {
        return "\(self.firstName) \(self.lastName)"
    }
    var email: String
    
    var billDictionary = [Int:Bill]()
    

    var TotalAmountToPay: Float // computed variable
    {
        var TotalAmount: Float = 0.0

        for bill in arrayBill
        {
            TotalAmount = TotalAmount + bill.totalBillAmount
        }
        return TotalAmount
    }
    
    init(){
        self.customerId = Int()
        self.firstName = String()
        self.lastName = String()
        self.email = String()
        self.arrayBill = Array()
    }
    init(customerId: Int, firstName: String, lastName: String, email: String , arrayOfBills: [Bill])
    {
        self.customerId = customerId
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
         self.arrayBill = arrayOfBills
    }
}


