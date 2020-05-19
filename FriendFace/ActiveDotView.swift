import SwiftUI

struct ActiveDotView: View {
    let isActive: Bool

    var body: some View {
        Circle()
            .foregroundColor(isActive ? .green : .gray)
            .frame(width: 12, height: 12)
    }
}

struct ActiveDotView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActiveDotView(isActive: true)
            ActiveDotView(isActive: false)
        }
        .previewLayout(.sizeThatFits)
    }
}
