import SwiftUI
import Combine

@MainActor
final class KeyboardObserver: ObservableObject {
    @Published var height: CGFloat = 0
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        let willChange = NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
        let willHide = NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
        
        willChange.merge(with: willHide)
            .receive(on: RunLoop.main)
            .sink { [weak self] note in
                guard let self = self else { return }
                withAnimation(.easeOut(duration: 0.25)) {
                    self.height = KeyboardObserver.keyboardHeight(from: note)
                }
            }
            .store(in: &cancellables)
    }
    
    private static func keyboardHeight(from notification: Notification) -> CGFloat {
        guard let userInfo = notification.userInfo else { return 0 }
        let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect) ?? .zero
        let height = max(0, UIScreen.main.bounds.height - endFrame.origin.y)
        return height
    }
}
