import Combine
import Foundation

extension PeopleListView {
    final class ViewModel: ObservableObject {
        private var disposables = Set<AnyCancellable>()
        private let friendService: FriendService

        @Published var errorHasOccurred = false
        @Published private(set) var isLoading = false
        @Published private(set) var people = [Person]()

        init(friendService: FriendService) {
            self.friendService = friendService
        }

        func fetchFriends() {
            isLoading = true

            friendService.fetchFriends()
                .sink(
                    receiveCompletion: { [weak self] value in
                        guard let self = self else { return }

                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.isLoading = false
                        }

                        switch value {
                        case .failure(let error):
                            self.errorHasOccurred = true
                            print(error)
                        case .finished:
                            break
                        }
                    },
                    receiveValue: { [weak self] people in
                        guard let self = self else { return }
                        self.people = people
                    }
                )
                .store(in: &disposables)
        }

        func detailViewModel(forPerson person: Person) -> PersonDetailView.ViewModel {
            PersonDetailView.ViewModel(person: person, friendService: friendService)
        }
    }
}
