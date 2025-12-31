import Foundation

struct UserArray: Codable {
  let users: [User]
  let total, skip, limit: Int
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let image: String
    let height: Double
    let weight: Double
    
    var education: String { "Master of computer application" }
    var work: String { "Working at xyz" }
    var aboutMe: String { "This is a sentence about me that will be appear in the app." }
    var basics: [UserInterest] {
        [
            UserInterest(icon: .icon("ruler"), text: "120"),
            UserInterest(icon: .icon("graduationcap"), text: "Graduated on IIT Bhopal"),
            UserInterest(icon: .icon("wineglass"), text: "Socially"),
            UserInterest(icon: .icon("moon.stars.fill"), text: "Virgo"),
        ]
    }
    
    var hobbies: [UserInterest] {
        [
            UserInterest(icon: .emoji("🏃"), text: "Running"),
            UserInterest(icon: .emoji("📙"), text: "Learning"),
            UserInterest(icon: .emoji("🎶"), text: "Music"),
            UserInterest(icon: .emoji("🧑‍🍳"), text: "Cooking")
        ]
    }
    
    var otherImages: [String] {
        [
            "https://plus.unsplash.com/premium_photo-1671656349322-41de944d259b?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D",
            "https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
            "https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTR8fHVzZXJ8ZW58MHx8MHx8fDA%3D",
            "https://images.unsplash.com/flagged/photo-1573740144655-bbb6e88fb18a?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTh8fHVzZXJ8ZW58MHx8MHx8fDA%3D"
        ]
    }
  
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}

struct UserInterest: Codable, Identifiable {
    var id = UUID().uuidString
    let icon: InterestIcon
    let text: String
    
    enum InterestIcon: Codable {
        case emoji(String)
        case icon(String)
    }
}

extension User {
    static let mock = User(
        id: 1,
        firstName: "Ankit",
        lastName: "Gupta",
        age: 32,
        email: "abc@gmail.com",
        phone: "2323232323",
        username: "abcUserName",
        password: "ababab",
        image: "https://images.unsplash.com/photo-1639149888905-fb39731f2e6c?q=80&w=1364&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        height: 120,
        weight: 45
    )
}

