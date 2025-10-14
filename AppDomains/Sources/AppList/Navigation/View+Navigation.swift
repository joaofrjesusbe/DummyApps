import SwiftUI
import AppGroup

extension View {
    func onNavigate(_ action: @escaping NavigateAction<ListRoute>.Action) -> some View {
        self.environment(\.imageNavigate, NavigateAction(action: action))
    }
}

struct DummyListNavigationEnvironmentKey: @preconcurrency EnvironmentKey {
    @MainActor static var defaultValue: NavigateAction = NavigateAction<ListRoute>(action: { _ in })
}

extension EnvironmentValues {
    var imageNavigate: (NavigateAction<DummyListRoute>) {
        get { self[DummyListNavigationEnvironmentKey.self] }
        set { self[DummyListNavigationEnvironmentKey.self] = newValue }
    }
}
