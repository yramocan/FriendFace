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
                HStack {
                    Text("Age")
                        .font(.headline)
                    Spacer()
                    Text("\(viewModel.age)")
                        .font(.callout)
                }

                HStack {
                    Text("Address")
                        .font(.headline)
                    Spacer()
                    Text("\(viewModel.address)")
                        .font(.callout)
                }

                HStack {
                    Text("Company")
                        .font(.headline)
                    Spacer()
                    Text("\(viewModel.company)")
                        .font(.callout)
                }

                HStack {
                    Text("Email")
                        .font(.headline)
                    Spacer()
                    Text("\(viewModel.email)")
                        .font(.callout)
                }

                HStack {
                    Text("Member Since")
                        .font(.headline)
                    Spacer()
                    Text("\(viewModel.memberSinceDateString)")
                        .font(.callout)
                }

                HStack {
                    Text("Interests")
                        .font(.headline)
                    Spacer()
                    Text("\(viewModel.interests)")
                        .font(.callout)
                }
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
