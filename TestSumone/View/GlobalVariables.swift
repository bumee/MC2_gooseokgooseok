//
//  GlobalVariables.swift
//  TestSumone
//
//  Created by kibum on 2023/05/02.
//

import Foundation
import SwiftUI

class QuestionData: ObservableObject, RandomAccessCollection {
    @Published var questions : [String] = []

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
    @Published var questions : [String] = []

    var startIndex: Int { questions.startIndex }
    var endIndex: Int { questions.endIndex }

    subscript(index: Int) -> String {
        questions[index]
    }

    func index(after i: Int) -> Int {
        questions.index(after: i)
    }
}
