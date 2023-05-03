//
//  TestSumoneApp.swift
//  TestSumone
//
//  Created by kibum on 2023/04/27.
//

import SwiftUI

@main
struct TestSumoneApp: App {
    @StateObject var questionData = QuestionData()
    @StateObject var waitingQuestionData = WaitingQuestionData()

    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(questionData)
                .environmentObject(waitingQuestionData)
        }
    }
}
