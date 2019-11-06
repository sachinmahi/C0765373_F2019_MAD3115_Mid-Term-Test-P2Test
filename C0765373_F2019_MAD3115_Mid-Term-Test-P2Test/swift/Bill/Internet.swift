

import Foundation

class Internet: Bill
{
    var providerName: String
    var internetUsed: Int
    
    init(Id: Int, billDate: Date, billType: billTypes, totalBillAmount: Float, providerName: String, internetUsed: Int)
    {
        self.providerName = providerName
        self.internetUsed = internetUsed
        
        super.init(Id: Id, billDate: billDate, billType: billType, totalBillAmount: totalBillAmount)
    }
}
