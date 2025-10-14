import SwiftUI
import AppGroup

struct ListView: View {
    @EnvironmentObject private var themer: ThemeManager
    @Environment(\.imageNavigate) private var navigate
    
    let onIntent: IntentSendable<ListIntent>
    let state: ListState
        
    var body: some View {
        ScrollView {
            VStack {
                listItems
                pageState
            }
            .background(themer.theme.background)
            .navigationTitle(state.query)
        }
        .background(themer.theme.background)
    }
    
    var listItems: some View {
        LazyVStack {
            ForEach(0..<state.listingItems.count, id: \.self) { index in
                let item = state.listingItems[index]
                DSListCell(
                    item: item,
                    didSelect: {
                        navigate(.push(.detail(index)))
                    }
                )
                .onAppear {
                    onIntent.send(.newItemAppeared(index))
                }
            }
        }
    }
    
    @ViewBuilder
    var pageState: some View {
        switch state.listingState {
        case .idle, .current:
            EmptyView()
        case .loading:
            ProgressView()
        case .failed(let error):
            Button(action: {
                onIntent.send(.loadNextPage)
            }) {
                VStack(alignment: .center) {
                    TextBundle(error.description)
                    TextBundle(AppCore.L10n.retry)
                }
            }
        }
    }
}

struct ImagesListView_Previews: DefaultPreviewProvider, PreviewProvider {
    static func content(for localeID: String) -> some View {
        NavigationStack {
            ListView(onIntent: MockIntentSendable(), state: .mock)
        }
    }
}
