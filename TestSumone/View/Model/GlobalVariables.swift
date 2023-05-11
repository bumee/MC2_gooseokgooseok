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

class WaitingQuestionData: ObservableObject, RandomAccessCollection {
    
    @Published var WaitingQuestions : [String:[String]] = [:]
    @Published var questions: [String] = []
    
    init() {
        fetchWaitingQuestions()
    }
    
    func fetchWaitingQuestions() {
        WaitingQuestions.removeAll()
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
                    if !self.WaitingQuestions.keys.contains(Person){
                        self.WaitingQuestions[Person] = [String]()
                    }
                    self.WaitingQuestions[Person]?.append(WaitingQuestion)
                }
            }
        }
    }
    
    func addWaitingQuestions(WaitingQuestion: String, userName: String) {
        let db = Firestore.firestore()
        let refs = db.collection("WaitingQuestions").document(WaitingQuestion)
        refs.setData(["Question": WaitingQuestion, "Person": userName]) { error in
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
    @Published var real_qeustions_bool : [String:Bool] = [:]
    @Published var questions: [String] = []
    @Published var isSimulated: Bool = false
    
    init() {
        fetchTodayQuestions()
    }
    
    func fetchTodayQuestions() {
        real_questions.removeAll()
        let db = Firestore.firestore()
        let refs = db.collection("TodayQuestion")
        refs.getDocuments {snapshot, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            if let snapshot = snapshot {
                for document in snapshot.documents {
                    let data = document.data()
                    let Today_Question = data["Question"] as? String ?? ""
                    
                    var InnerInnerDict = [String:String]()
                    let fieldNames = Array(data.keys)
                    for Name in fieldNames {
                        if Name != "Question" {
                            let it = data[Name] as? String ?? ""
                            InnerInnerDict[Name] = it
                        }
                    }
                    self.real_questions[Today_Question] = InnerInnerDict
                    self.real_qeustions_bool[Today_Question] = false
                }
            }
        }
        print(real_questions)
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
    
    func saveTodayQuestions(TodayQuestion: String) {
        let db = Firestore.firestore()
        let refs = db.collection("TodayQuestion").document(TodayQuestion)
        refs.setData(["Question": TodayQuestion]) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
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
    @Published var Dates: [String] = []
    
    
    init() {
        fetchPreviousQuestions()
    }
    
    func fetchPreviousQuestions() {
        questions.removeAll()
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
                    let Previous_Question = data["PreviousQuestion"] as? String ?? ""
                    let Dates = data["Date"] as? String ?? ""
                    let Answer = data["Answer"] as? [String:String] ?? [String:String]()
                    self.questions[Previous_Question] = Answer
                    
                    self.Dates.append(Dates)
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
                    print(person)
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
            print("알림 성공인데?")
        } else {
            print("Notification permission denied")
        }
    }
}
