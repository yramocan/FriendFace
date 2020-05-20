import Combine
import Foundation

extension PersonDetailView {
    final class ViewModel: ObservableObject {
        private var disposables = Set<AnyCancellable>()
        private let friendService: FriendService

        @Published var friends = [Person]()
        @Published private var person: Person

        var about: String { person.about.trimmingCharacters(in: .whitespacesAndNewlines) }
        var address: String { person.address }
        var ageString: String { String(person.age) }
        var company: String { person.company }
        var email: String { person.email }
        var interests: String { person.tags.joined(separator: ", ") }
        var isActive: Bool { person.isActive }
        var name: String { person.name }

        var memberSinceDateString: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy"
            return formatter.string(from: person.registered)
        }

        init(person: Person, friendService: FriendService) {
            self.friendService = friendService
            self.person = person
        }

        func fetchFriends() {
            Publishers.Sequence<[AnyPublisher<Person, Error>], Error>(sequence: person.friends.map {
                friendService.fetchFriend(withID: $0.id)
            })
            .flatMap { $0 }
            .collect()
            .sink(
                receiveCompletion: { value in
                    switch value {
                    case .failure(let error):
                        print(error)
                    case .finished:
                        break
                    }
                }, receiveValue: { friends in
                    self.friends = friends
                }
            )
            .store(in: &disposables)
        }

        func detailViewModel(forPerson person: Person) -> PersonDetailView.ViewModel {
            PersonDetailView.ViewModel(person: person, friendService: friendService)
        }
    }
}
