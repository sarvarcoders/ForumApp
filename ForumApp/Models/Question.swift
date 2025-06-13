import Foundation
import FirebaseFirestoreSwift

struct Question: Identifiable, Codable {
    @DocumentID var id: String?       // Firestore hujjat ID
    var userID: String                // Kim yozgan
    var title: String                 // Savol sarlavhasi
    var body: String                  // Savol matni
    var timestamp: Date               // Qo‘shilgan vaqt
    var likedBy: [String]             // Like bosgan userID’lar

    init(id: String? = nil, userID: String, title: String, body: String, timestamp: Date = Date(), likedBy: [String] = []) {
        self.id = id
        self.userID = userID
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.likedBy = likedBy
    }
}
