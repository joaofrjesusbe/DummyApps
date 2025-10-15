import SwiftUI

public struct CollapsingHeaderImage: View {
    let url: URL?
    let minHeight: CGFloat = 220

    public init(url: URL?) {
        self.url = url
    }
    
    public var body: some View {
        GeometryReader { geo in
            let y = geo.frame(in: .global).minY
            RemoteImage(url: url)
                // Ensure image is pinned to the top-center instead of top-left
                .frame(maxWidth: .infinity, alignment: .top)
                .frame(height: max(minHeight, minHeight + y))
                .clipped()
                .offset(y: y < 0 ? y/2 : -y) // subtle parallax
        }
        .frame(height: minHeight)
    }
}

#Preview {
    CollapsingHeaderImage(
        url: URL(filePath: "https://cdn.pixabay.com/photo/2015/11/17/13/13/puppy-1047521_150.jpg")!
        )
}
