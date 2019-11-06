
import Foundation

extension Date
{
    public func getForamttedDate() -> String
    {
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy"
        // in the format "Thursday, 20 june, 2019
        var formattedDate = dateFormatter.string(from: self)
        return formattedDate
}
}
