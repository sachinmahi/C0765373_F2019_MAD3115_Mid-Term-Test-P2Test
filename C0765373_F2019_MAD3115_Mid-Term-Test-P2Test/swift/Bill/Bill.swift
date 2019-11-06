


import Foundation


class  Bill {
    
    var Id: Int
    var billDate: Date
    var billType: billTypes
    var totalBillAmount: Float
    
    init()
    {
        self.Id = Int()
        self.billDate = Date()
        self.billType = billTypes.None
        self.totalBillAmount = Float()
    }
    
    init(Id: Int, billDate: Date, billType: billTypes, totalBillAmount: Float)
    {
        self.Id = Id
        self.billDate = billDate
        self.billType = billType
        self.totalBillAmount = totalBillAmount
    }
}
