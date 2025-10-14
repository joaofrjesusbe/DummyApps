import AppGroup

extension ListState {
    @MainActor
    static var mock: Self {
        var itemMocks: [DSListCellItem] = []
        let adapter = ImageInfoUIAdapter()
        for _ in 0..<20 {
            itemMocks.append(adapter.toCellItem(.mock))
        }
        
        return ListState(
            query: "Testing",
            listingItems: itemMocks,
            listingState: .loading
        )
    }
}
