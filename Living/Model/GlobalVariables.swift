//
//  GlobalVariables.swift
//  TestSumone
//
//  Created by kibum on 2023/05/02.
//

import Foundation
import SwiftUI
import UserNotifications
import Firebase

class HistoryQuestionData: ObservableObject, RandomAccessCollection {
    
    @Published var HistoryQuestions : [String:[String]] = [:]
    @Published var questions: [String] = []
    
    init() {
        fetchHistoryQuestions()
    }
    
    func fetchHistoryQuestions() {
        HistoryQuestions.removeAll()
        let db = Firestore.firestore()
        let refs = db.collection("HistoryQuestions")
        refs.getDocuments {snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let HistoryQuestion = data["Question"] as? String ?? ""
                    let Person = data["Person"] as? String ?? ""
                    if !self.HistoryQuestions.keys.contains(Person){
                        self.HistoryQuestions[Person] = [String]()
                    }
                    self.HistoryQuestions[Person]?.append(HistoryQuestion)
                }
            }
        }
    }
    
    func addHistoryQuestions(HistoryQuestion: String, userName: String) {
        let db = Firestore.firestore()
        let refs = db.collection("HistoryQuestions").document(HistoryQuestion)
        refs.setData(["Question": HistoryQuestion, "Person": userName]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    var startIndex: Int { questions.startIndex }
    var endIndex: Int { questions.endIndex }

    subscript(index: Int) -> String {
        questions[index]
    }

    func index(after i: Int) -> Int {
        questions.index(after: i)
    }
}

class WaitingQuestionData: ObservableObject, RandomAccessCollection {
    
    @Published var WaitingQuestions : [String:[String]] = [:]
    @Published var WaitingQuestions_Date: [String:String] = [:]
    @Published var questions: [String] = []
    let dateFormatter = DateFormatter()
    var dateString = String()
    
    init() {
        fetchWaitingQuestions()
    }
    
    func fetchWaitingQuestions() {
        WaitingQuestions.removeAll()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let db = Firestore.firestore()
        let refs = db.collection("WaitingQuestions")
        refs.getDocuments {snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let WaitingQuestion = data["Question"] as? String ?? ""
                    let Person = data["Person"] as? String ?? ""
                    let Timestamps = data["Date"] as? Timestamp ?? Timestamp()
                    let Date = Timestamps.dateValue()
                    if !self.WaitingQuestions.keys.contains(Person){
                        self.WaitingQuestions[Person] = [String]()
                    }
                    self.dateString = self.dateFormatter.string(from: Date)
                    self.WaitingQuestions_Date[WaitingQuestion] = self.dateString
                    self.WaitingQuestions[Person]?.append(WaitingQuestion)
                }
            }
        }
    }
    
    func addWaitingQuestions(WaitingQuestion: String, userName: String) {
        let db = Firestore.firestore()
        let refs = db.collection("WaitingQuestions").document(WaitingQuestion)
        refs.setData(["Question": WaitingQuestion, "Person": userName, "Date": Date()]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteWaitingQuestions(WaitingQuestion: String) {
        let db = Firestore.firestore()
        let refs = db.collection("WaitingQuestions").document(WaitingQuestion)
        refs.delete() { error in
            if let error = error {
                print("\(error)")
            }
            else {
                print("성공적으로 지워짐")
            }
        }
    }
    
    func MoveToTodayQuestionData(DocumentId: String) {
        let sourceCollection = Firestore.firestore().collection("WaitingQuestions")

        // 이동할 문서의 대상 콜렉션 참조
        let destinationCollection = Firestore.firestore().collection("TodayQuestion")

        // 이동할 문서의 고유 식별자
        let documentID = DocumentId

        // 문서 가져오기
        sourceCollection.document(documentID).getDocument { (snapshot, error) in
            if let error = error {
                print("문서 가져오기 오류: \(error.localizedDescription)")
                return
            }

            guard let documentData = snapshot?.data() else {
                print("문서가 존재하지 않습니다.")
                return
            }

            // 대상 콜렉션에 문서 복사하기
            destinationCollection.document(documentID).setData(documentData) { (error) in
                if let error = error {
                    print("문서 복사 오류: \(error.localizedDescription)")
                    return
                }

                // 원본 콜렉션에서 문서 삭제하기
                sourceCollection.document(documentID).delete { (error) in
                    if let error = error {
                        print("문서 삭제 오류: \(error.localizedDescription)")
                        return
                    }

                    print("문서 이동 완료")
                }
            }
        }
    }
    
    func MoveToHistoryQuestionData(DocumentId: String) {
        let sourceCollection = Firestore.firestore().collection("WaitingQuestions")

        // 이동할 문서의 대상 콜렉션 참조
        let destinationCollection = Firestore.firestore().collection("HistoryQuestions")

        // 이동할 문서의 고유 식별자
        let documentID = DocumentId

        // 문서 가져오기
        sourceCollection.document(documentID).getDocument { (snapshot, error) in
            if let error = error {
                print("문서 가져오기 오류: \(error.localizedDescription)")
                return
            }

            guard let documentData = snapshot?.data() else {
                print("문서가 존재하지 않습니다.")
                return
            }

            // 대상 콜렉션에 문서 복사하기
            destinationCollection.document(documentID).setData(documentData) { (error) in
                if let error = error {
                    print("문서 복사 오류: \(error.localizedDescription)")
                    return
                }

                // 원본 콜렉션에서 문서 삭제하기
                sourceCollection.document(documentID).delete { (error) in
                    if let error = error {
                        print("문서 삭제 오류: \(error.localizedDescription)")
                        return
                    }

                    print("문서 이동 완료")
                }
            }
        }
    }

    var startIndex: Int { questions.startIndex }
    var endIndex: Int { questions.endIndex }

    subscript(index: Int) -> String {
        questions[index]
    }

    func index(after i: Int) -> Int {
        questions.index(after: i)
    }
}

class TodayQuestionData: ObservableObject, RandomAccessCollection {
    
    @Published var real_questions: [String:[String:String]] = [:]
    @Published var real_questions_Date: [String:String] = [:]
    @Published var real_qeustions_bool : [String:Bool] = [:]
    @Published var questions: [String] = []
    @Published var isSimulated: Bool = false
    let dateFormatter = DateFormatter()
    var dateString = String()
    
    init() {
        fetchTodayQuestions()
    }
    
    func fetchTodayQuestions() {
        real_questions.removeAll()
        let db = Firestore.firestore()
        let refs = db.collection("TodayQuestion")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        refs.getDocuments {snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let Today_Question = data["Question"] as? String ?? ""
                    let Timestamps = data["Date"] as? Timestamp ?? Timestamp()
                    let Date = Timestamps.dateValue()
                    self.dateString = self.dateFormatter.string(from: Date)
                    var InnerInnerDict = [String:String]()
                    let fieldNames = Array(data.keys)
                    for Name in fieldNames {
                        if Name != "Question" && Name != "Date" && Name != "Person" {
                            let it = data[Name] as? String ?? ""
                            InnerInnerDict[Name] = it
                        }
                    }
                    self.real_questions_Date[Today_Question] = self.dateString
                    self.real_questions[Today_Question] = InnerInnerDict
                    self.real_qeustions_bool[Today_Question] = false
                }
            }
        }
    }
    
    func addAnswerTodayQuestion(TodayQuestion: String, Statement: String, userName: String) {
        let db = Firestore.firestore()
        let refs = db.collection("TodayQuestion").document(TodayQuestion)
        refs.updateData([userName: Statement]) { (error) in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
//    func saveTodayQuestions(TodayQuestion: String) {
//        let db = Firestore.firestore()
//        let refs = db.collection("TodayQuestion").document(TodayQuestion)
//        refs.setData(["Question": TodayQuestion]) { error in
//            if let error = error {
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    func deleteTodayQuestions(TodayQuestion: String) {
        let db = Firestore.firestore()
        let refs = db.collection("TodayQuestion").document(TodayQuestion)
        refs.delete() { error in
            if let error = error {
                print("\(error)")
            }
            else {
                print("성공적으로 지워짐")
            }
        }
    }
    
    func MoveToPreviousQuestionData(DocumentId: String) {
        let sourceCollection = Firestore.firestore().collection("TodayQuestion")

        // 이동할 문서의 대상 콜렉션 참조
        let destinationCollection = Firestore.firestore().collection("PreviousQuestions")

        // 이동할 문서의 고유 식별자
        let documentID = DocumentId

        // 문서 가져오기
        sourceCollection.document(documentID).getDocument { (snapshot, error) in
            if let error = error {
                print("문서 가져오기 오류: \(error.localizedDescription)")
                return
            }

            guard let documentData = snapshot?.data() else {
                print("문서가 존재하지 않습니다.")
                return
            }

            // 대상 콜렉션에 문서 복사하기
            destinationCollection.document(documentID).setData(documentData) { (error) in
                if let error = error {
                    print("문서 복사 오류: \(error.localizedDescription)")
                    return
                }

                // 원본 콜렉션에서 문서 삭제하기
                sourceCollection.document(documentID).delete { (error) in
                    if let error = error {
                        print("문서 삭제 오류: \(error.localizedDescription)")
                        return
                    }

                    print("문서 이동 완료")
                }
            }
        }
    }

    var startIndex: Int { questions.startIndex }
    var endIndex: Int { questions.endIndex }

    subscript(index: Int) -> String {
        questions[index]
    }

    func index(after i: Int) -> Int {
        questions.index(after: i)
    }
}

class PreviousQuestionData: ObservableObject, RandomAccessCollection {
    
    @Published var questions : [String:[String:String]] = [:]
    @Published var questions_Date : [String:String] = [:]
    @Published var question_Timestamp : [String:Date] = [:]
    @Published var sortedQuestions : [String] = []
    @Published var Dates: [String] = []
    let dateFormatter = DateFormatter()
    var dateString = String()
    
    init() {
        fetchPreviousQuestions()
    }
    
    func findKey(forValue value: Int, in dictionary: [String: Int]) -> String? {
        for (key, dictValue) in dictionary {
            if dictValue == value {
                return key
            }
        }
        return nil
    }
    
    func fetchPreviousQuestions() {
        questions.removeAll()
        questions_Date.removeAll()
        sortedQuestions.removeAll()
        question_Timestamp.removeAll()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let db = Firestore.firestore()
        let refs = db.collection("PreviousQuestions")
        refs.getDocuments {snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let Previous_Question = data["Question"] as? String ?? ""
                    let Timestamps = data["Date"] as? Timestamp ?? Timestamp()
                    let Date = Timestamps.dateValue()
                    var InnerInnerDict = [String:String]()
                    let fieldNames = Array(data.keys)
                    for Name in fieldNames {
                        if Name != "Question" && Name != "Date" && Name != "Person" {
                            let it = data[Name] as? String ?? ""
                            InnerInnerDict[Name] = it
                        }
                    }
                    self.question_Timestamp[Previous_Question] = Date
                    self.sortedQuestions = self.question_Timestamp.sorted { $0.value > $1.value }.map{ $0.key }
                    
                    self.dateString = self.dateFormatter.string(from: Date)
                    self.questions_Date[Previous_Question] = self.dateString
                    self.questions[Previous_Question] = InnerInnerDict
                }
            }
        }
        
        self.Dates = self.Dates.reversed()
    }
    
    func addLocal_PreviousQuestion(Date: String, Previous_Question: String) {
        self.Dates.append(Date)
        self.questions[Previous_Question] = [String:String]()
    }
    
    func addingToServer_PreviousQuestion(Date: String, Previous_Question: String) {
        let db = Firestore.firestore()
        let refs = db.collection("PreviousQuestions").document(Previous_Question)
        refs.setData(["Date": Date, "Question": Previous_Question]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }

    var startIndex: Int { Dates.startIndex }
    var endIndex: Int { Dates.endIndex }

    subscript(index: Int) -> String {
        Dates[index]
    }

    func index(after i: Int) -> Int {
        Dates.index(after: i)
    }
}
    

class EmojiList : ObservableObject, RandomAccessCollection {
    @Published var Emojis : [String] = ["👵🏻","👴🏻","👨🏻","🧑🏻","🧑🏻‍🦱","👩🏻","👧🏻","👦🏻"]

    var startIndex: Int { Emojis.startIndex }
    var endIndex: Int { Emojis.endIndex }

    subscript(index: Int) -> String {
        Emojis[index]
    }

    func index(after i: Int) -> Int {
        Emojis.index(after: i)
    }
}

struct Person {
    var Emoji : String = ""
    
    var NickName : String = ""
    
    var Answer = [String:String]()
}

class DataManager: ObservableObject, RandomAccessCollection {
    @Published var Persons : [Person] = []
    
    init() {
        fetchPersons()
    }
    
    func fetchPersons() {
        Persons.removeAll()
        let db = Firestore.firestore()
        let refs = db.collection("Persons")
        refs.getDocuments { snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    
                    let NickName = data["NickName"] as? String ?? ""
                    let Emoji = data["Emoji"] as? String ?? ""
                    let Answer = data["Answer"] as? Dictionary ?? [String:String]()
                    
                    let person = Person(Emoji: Emoji, NickName: NickName, Answer: Answer)
                    self.Persons.append(person)
                }
            }
        }
    }
    
    func addPerson(PersonName: String, Emoji: String, WaitingQuestionList: [String]) {
        let db = Firestore.firestore()
        let refs = db.collection("Persons").document(PersonName)
        refs.setData(["Emoji": Emoji, "NickName": PersonName, "Answer": [Int:String](), "WaitingQuestions": WaitingQuestionList]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    var startIndex: Int { Persons.startIndex }
    var endIndex: Int { Persons.endIndex }

    subscript(index: Int) -> Person {
        Persons[index]
    }

    func index(after i: Int) -> Int {
        Persons.index(after: i)
    }
}

func SendLocalNotification(Title: String, Subtitle: String, body: String) {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
        if granted {
            // Step 2: Create a notification content object
            let content = UNMutableNotificationContent()
            content.title = Title
            content.subtitle = Subtitle
            content.body = body
            content.sound = UNNotificationSound.default

            // Step 3: Create a notification trigger object
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

            // Step 4: Create a notification request object
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

            // Step 5: Add the notification request to the notification center
            UNUserNotificationCenter.current().add(request)
        } else {
            print("Notification permission denied")
        }
    }
}
