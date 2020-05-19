import Foundation

struct Person: Decodable, Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}

struct Friend: Decodable, Identifiable {
    let id: String
    let name: String
}

extension Person {
    static var names = [
        "Jonie Santigo",
        "Ronda Lei",
        "Lakesha Dang",
        "Reina Digiovanni",
        "Iola Klausner",
        "Cody Scism",
        "Blanche Milholland",
        "Sumiko Catlett",
        "Delma Washinton",
        "Zachery Giard"
    ]

    static var friends = [
        Friend(id: "91b5be3d-9a19-4ac2-b2ce-89cc41884ed0", name: "Hawkins Patel"),
        Friend(id: "0c395a95-57e2-4d53-b4f6-9b9e46a32cf6", name: "Jewel Sexton"),
        Friend(id: "be5918a3-8dc2-4f77-947c-7d02f69a58fe", name: "Berger Robertson"),
        Friend(id: "f2f86852-8f2d-46d3-9de5-5bed1af9e4d6", name: "Hess Ford"),
        Friend(id: "6ba32d1b-38d7-4b0f-ba33-1275345eacc0", name: "Bonita White")
    ]

    static func mock(id: String = UUID().uuidString,
                     isActive: Bool = false,
                     name: String = names.randomElement()!,
                     age: Int = Int.random(in: 18...80),
                     company: String = "Detroit Labs",
                     email: String = "email@example.com",
                     address: String = "123 Main Street #32, Anywhere, MI, USA",
                     about: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                     registered: Date = Date(),
                     tags: [String] = ["Music", "Travel", "Foodie", "Swimming", "Hiking"],
                     friends: [Friend] = friends) -> Person {
        Person(id: id,
               isActive: isActive,
               name: name,
               age: age,
               company: company,
               email: email,
               address: address,
               about: about,
               registered: registered,
               tags: tags,
               friends: friends)
    }
}
