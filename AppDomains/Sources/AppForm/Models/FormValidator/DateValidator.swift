import Foundation

struct DateValidator {
    func validate(_ date: Date?) -> String? {
        guard let date = date else {
            return NSLocalizedString("error_empty", bundle: .module, comment: "")
        }
        
        let calendar = Calendar.current
        
        // Check if Monday
        let weekday = calendar.component(.weekday, from: date)
        if weekday == 2 { // Sunday = 1, Monday = 2
            return NSLocalizedString("error_date_monday", bundle: .module, comment: "")
        }
        
        // Check if future
        let startOfToday = calendar.startOfDay(for: Date())
        let startOfSelectedDay = calendar.startOfDay(for: date)
        if startOfSelectedDay > startOfToday {
            return NSLocalizedString("error_date_future", bundle: .module, comment: "")
        }
        
        return nil
    }
}
