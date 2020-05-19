import Combine
import Foundation

final class FriendService: ObservableObject {
    @Published private(set) var friends = [Person]()

    func fetchFriend(withID id: String) -> AnyPublisher<Person, Error> {
        return Future { promise in
            guard let friend = self.friends.first(where: { $0.id == id }) else {
                promise(.failure(NetworkError.notFound))
                return
            }

            promise(.success(friend))
        }
        .eraseToAnyPublisher()
    }

    func fetchFriends() -> AnyPublisher<[Person], Error> {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            return Fail(error: NetworkError.urlError).eraseToAnyPublisher()
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        return URLSession.shared
            .dataTaskPublisher(for: URLRequest(url: url))
            .tryMap { result -> [Person] in
                let people = try decoder.decode([Person].self, from: result.data)
                self.friends = people
                return people
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

enum NetworkError: Error {
    case badData
    case notFound
    case urlError
}
