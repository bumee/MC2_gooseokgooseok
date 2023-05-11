//
//  TestSumoneApp.swift
//  TestSumone
//
//  Created by kibum on 2023/04/27.
//

import SwiftUI
import Firebase

@main
struct TestSumoneApp: App {
    @StateObject var questionData = PreviousQuestionData()
    @StateObject var Emojis = EmojiList()
    @StateObject var dataBase = DataManager()
    @StateObject var TodayQuestions = TodayQuestionData()
    @StateObject var WaitingQuestions = WaitingQuestionData()
    
    init(){
        FirebaseApp.configure()
    }
    
    var islog = false
    
    var body: some Scene {
        WindowGroup {
            MainView(userName: "", isLoggedIn: false, SelectedEmojiIdx: 0)
                .environmentObject(questionData)
                .environmentObject(Emojis)
                .environmentObject(dataBase)
                .environmentObject(TodayQuestions)
                .environmentObject(WaitingQuestions)
        }
    }
}
