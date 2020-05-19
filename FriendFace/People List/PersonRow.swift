import SwiftUI

struct PersonRow: View {
    let person: Person

    var body: some View {
        HStack {
            ActiveDotView(isActive: person.isActive)

            Text(person.name)
                .font(.headline)

            Text(person.company)
                .font(.caption)
                .foregroundColor(.secondary)

            Spacer()
        }
    }
}

struct PersonRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PersonRow(person: .mock(isActive: true))
            PersonRow(person: .mock(isActive: false))
        }
        .previewLayout(.sizeThatFits)
    }
}
