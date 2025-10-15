import Foundation

extension DateFormatter {
    static let ptShort: DateFormatter = {
        let df = DateFormatter()
        df.locale = Locale(identifier: "pt_PT")
        df.dateStyle = .medium
        return df
    }()
}
