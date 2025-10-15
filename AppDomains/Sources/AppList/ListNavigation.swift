import SwiftUI
import AppGroup

public struct ListNavigation: View, NavigationRoutable {
    @State public private(set) var routes: [ListRoute] = []
    
    public init() {}
    
    public var body: some View {
        NavigationStack(path: $routes) {
            ProductListView(viewModel: ListDI.getListViewModel())
                .navigationDestination(for: ListRoute.self) { route in
                    switch route {
                    case .detail(let product):
                        EmptyView()
                    }
                }
        }        
        .onNavigate(handleNavigation)
    }
    
    public func handleNavigation(_ navType: NavigationType<Route>) {
        handleNavigationStack(stack: &routes, navType: navType)
    }
}
