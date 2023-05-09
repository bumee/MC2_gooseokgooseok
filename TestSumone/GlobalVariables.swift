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

class PreviousQuestionData: ObservableObject, RandomAccessCollection {
    @Published var questions : [String] = []
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
                    
                    self.questions.append(Previous_Question)
                    self.Dates.append(Dates)
                }
            }
        }
        self.Dates = self.Dates.reversed()
    }
    
    func addLocal_PreviousQuestion(Date: String, Previous_Question: String) {
        self.Dates.append(Date)
        self.questions.append(Previous_Question)
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

    var startIndex: Int { questions.startIndex }
    var endIndex: Int { questions.endIndex }

    subscript(index: Int) -> String {
        questions[index]
    }

    func index(after i: Int) -> Int {
        questions.index(after: i)
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
    
    var WaitingQuestions = [String]()
}

class DataManager: ObservableObject, RandomAccessCollection {
    @Published var Persons : [Person] = []
    @Published var WaitingQuestions : [String] = []
    
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
                    let WaitingQuestions = data["WaitingQuestions"] as? [String] ?? [String]()
                    
                    let person = Person(Emoji: Emoji, NickName: NickName, Answer: Answer, WaitingQuestions: WaitingQuestions)
                    print(person)
                    self.Persons.append(person)
                }
            }
        }
    }
    
    func fetchWaitingQuestions(PersonName: String) -> [String] {
        let db = Firestore.firestore()
        let refs = db.collection("Persons").document(PersonName)
        var WaitingQuestionList : [String] = []
        refs.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                WaitingQuestionList = data?["WaitingQuestions"] as? [String] ?? [String]()
            }
            else {
                print("잘못 입력된 문서 이름입니다.")
            }
        }
        print(WaitingQuestionList)
        return WaitingQuestionList
    }
    
    func AddWaitingQuestions(Statement: String) {
        WaitingQuestions.append(Statement)
    }

    func SaveWaitingQuestion(PersonName: String, NewWaitingQuestionList: [String]) {
        let db = Firestore.firestore()
        let refs = db.collection("Persons").document(PersonName)
        refs.updateData(["WaitingQuestions": NewWaitingQuestionList]) { (error) in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func fixWaitingQuestions(PersonName: String, OrigianlStatement: String, FixStatement: String) {
        let db = Firestore.firestore()
        let refs = db.collection("Persons").document(PersonName)
        var OriginalQuestions = self.fetchWaitingQuestions(PersonName: PersonName)
        if let idx = OriginalQuestions.firstIndex(of: OrigianlStatement) {
            OriginalQuestions[idx] = FixStatement
        }
        refs.updateData(["WaitingQuestions": OriginalQuestions]) { (error) in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
            }
        }
    }
    
    func deleteWaitingQuestions(PersonName: String, Statement: String) {
        let db = Firestore.firestore()
        let refs = db.collection("Persons").document(PersonName)
        var OriginalQuestions = self.fetchWaitingQuestions(PersonName: PersonName)
        if let idx = OriginalQuestions.firstIndex(of: Statement) {
            OriginalQuestions.remove(at: idx)
        }
        refs.updateData(["WaitingQuestions": OriginalQuestions]) { (error) in
            if let error = error {
                print("Error updating document: \(error)")
            } else {
                print("Document successfully updated")
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
