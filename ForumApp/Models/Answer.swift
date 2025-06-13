import Foundation
import FirebaseFirestoreSwift

struct Answer: Identifiable, Codable {
    @DocumentID var id: String?         // Firestore document ID
    var questionID: String              // Qaysi savolga yozilgan
    var userID: String                  // Kim yozgan
    var userEmail: String               // Email (ko‘rsatish uchun)
    var body: String                    // Javob matni
    var timestamp: Date                 // Yozilgan vaqt

    init(id: String? = nil, questionID: String, userID: String, userEmail: String, body: String, timestamp: Date = Date()) {
        self.id = id
        self.questionID = questionID
        self.userID = userID
        self.userEmail = userEmail
        self.body = body
        self.timestamp = timestamp
    }
}
