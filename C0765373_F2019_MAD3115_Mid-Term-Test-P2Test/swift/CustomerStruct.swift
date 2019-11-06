
import Foundation

struct CustomersStruct {
    let customerID : Int
    var customerFName : String
    var customerLName : String
    var email : String
    var password : String
    
    var fullName : String{
        return "\(customerFName ) \(customerLName)"
    }
    
}
