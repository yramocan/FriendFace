import SwiftUI

struct PeopleListView: View {
    @State private var showingErrorAlert = false
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            Group {
                if !viewModel.isLoading && !viewModel.errorHasOccurred {
                    listView
                } else {
                    if viewModel.isLoading {
                        ActivityIndicator()
                            .foregroundColor(.blue)
                            .frame(width: 50, height: 50)
                    } else if viewModel.errorHasOccurred {
                        Text("Error has occurred.")
                    }
                }
            }
            .navigationBarTitle("Friends")
            .navigationBarItems(trailing:
                Button(action: {
                    self.viewModel.fetchFriends()
                }) {
                    Image(systemName: "arrow.clockwise")
                }
            )
        }
        .onAppear(perform: viewModel.fetchFriends)
        .alert(isPresented: $viewModel.errorHasOccurred) {
            Alert(title: Text("Error has occurred."),
                  message: Text("Please try again."),
                  dismissButton: .default(Text("OK")))
        }
    }

    private var listView: some View {
        Group {
            if viewModel.people.isEmpty {
                Text("There are no people to list.")
            } else {
                List(viewModel.people) { person in
                    NavigationLink(destination: PersonDetailView(viewModel: self.viewModel.detailViewModel(forPerson: person))) {
                        PersonRow(person: person)
                    }
                }
            }
        }
    }
}

struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
        PeopleListView(
            viewModel: PeopleListView.ViewModel(
                friendService: FriendService()
            )
        )
    }
}
