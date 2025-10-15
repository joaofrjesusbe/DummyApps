import SwiftUI
import AppList
import AppForm

@main
struct DummyJsonApp: App {
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch AppMode.current() {
                case .form:
                    FormNavigation()
                case .listAndDetail:
                    ListNavigation()
                }
            }
        }
    }
}
