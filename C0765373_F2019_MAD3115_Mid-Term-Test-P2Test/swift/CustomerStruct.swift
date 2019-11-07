//
//  CustomerStruct.swift
//  C0765373_F2019_MAD3115_Mid-Term-Test-P2Test
//
//  Created by simar mahi on 04/11/19.
//  Copyright © 2019 MacStudent. All rights reserved.
//
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
