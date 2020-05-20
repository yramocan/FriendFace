import SwiftUI

struct PersonDetailView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        List {
            HStack {
                ActiveDotView(isActive: viewModel.isActive)
                Text(viewModel.isActive ? "Online" : "Offline")
            }

            Section(header: Text("General")) {
                infoItem(title: "Age", description: viewModel.ageString)
                infoItem(title: "Address", description: viewModel.address)
                infoItem(title: "Company", description: viewModel.company)
                infoItem(title: "Email", description: viewModel.email)
                infoItem(title: "Member Since", description: viewModel.memberSinceDateString)
                infoItem(title: "Interests", description: viewModel.interests)
            }

            Section(header: Text("About")) {
                Text(viewModel.about)
            }

            Section(header: Text("Friends")) {
                ForEach(viewModel.friends) { friend in
                    NavigationLink(destination: PersonDetailView(viewModel: self.viewModel.detailViewModel(forPerson: friend))) {
                        PersonRow(person: friend)
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .onAppear(perform: viewModel.fetchFriends)
        .navigationBarTitle(viewModel.name)
    }

    private func infoItem(title: String, description: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text(description)
                .font(.callout)
                .lineLimit(2)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(
            viewModel: PersonDetailView.ViewModel(
                person: .mock(),
                friendService: FriendService()
            )
        )
    }
}
