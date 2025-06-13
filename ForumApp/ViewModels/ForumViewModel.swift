import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class ForumViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var answers: [Answer] = []

    private let db = Firestore.firestore()
    private let questionCollection = "questions"
    private let answerCollection = "answers"

    // 🔄 Barcha savollarni yuklaydi
    func loadQuestions() {
        db.collection(questionCollection)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("❌ Error fetching questions:", error?.localizedDescription ?? "Unknown")
                    return
                }

                self.questions = documents.compactMap { doc -> Question? in
                    try? doc.data(as: Question.self)
                }
            }
    }

    // 🆕 Savol qo‘shish
    func addQuestion(userID: String, title: String, body: String, completion: @escaping (Error?) -> Void) {
        let question = Question(userID: userID, title: title, body: body)
        do {
            _ = try db.collection(questionCollection).addDocument(from: question, completion: completion)
        } catch {
            completion(error)
        }
    }

    // 📥 Javoblar ro‘yxatini yuklaydi
    func loadAnswers(for question: Question) {
        db.collection(answerCollection)
            .whereField("questionID", isEqualTo: question.id ?? "")
            .order(by: "timestamp", descending: false)
            .addSnapshotListener { snapshot, error in
                guard let documents = snapshot?.documents else {
                    print("❌ Error fetching answers:", error?.localizedDescription ?? "Unknown")
                    return
                }

                self.answers = documents.compactMap { doc -> Answer? in
                    try? doc.data(as: Answer.self)
                }
            }
    }

    // 📝 Yangi javob qo‘shish
    func addAnswer(to question: Question, userID: String, email: String, body: String, completion: @escaping (Error?) -> Void) {
        let answer = Answer(
            questionID: question.id ?? "",
            userID: userID,
            userEmail: email,
            body: body
        )

        do {
            _ = try db.collection(answerCollection).addDocument(from: answer, completion: completion)
        } catch {
            completion(error)
        }
    }
    
    // ❤️ Savolga like bosish
    func likeQuestion(_ question: Question, currentUserID: String) {
        guard let id = question.id else { return }

        let ref = db.collection(questionCollection).document(id)

        db.runTransaction({ (transaction, errorPointer) -> Any? in
            let document: DocumentSnapshot
            do {
                document = try transaction.getDocument(ref)
            } catch {
                print("❌ Transaction error: \(error.localizedDescription)")
                return nil
            }

            // likedBy array’ni olish
            var likedBy = document.data()?["likedBy"] as? [String] ?? []

            // Agar foydalanuvchi like bosgan bo‘lsa — hech narsa qilinmaydi
            if likedBy.contains(currentUserID) {
                return nil
            }

            // Yangi userID qo‘shamiz
            likedBy.append(currentUserID)

            // Yangilash
            transaction.updateData(["likedBy": likedBy], forDocument: ref)

            return nil
        }) { (_, error) in
            if let error = error {
                print("❌ Like error: \(error.localizedDescription)")
            }
        }
    }

}
