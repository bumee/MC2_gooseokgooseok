//
//  SwiftUIView.swift
//  TestSumone
//
//  Created by moon on 2023/05/01.
//

import SwiftUI

struct Task: Identifiable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
    
}

struct TaskMetaData: Identifiable {
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
}

func getSampleData(offset: Int)->Date {
    let calendar = Calendar.current
    let date = calendar.date(byAdding:.day, value: offset, to: Date())
    
    return date ?? Date()
}


var tasks: [TaskMetaData] = [

    TaskMetaData(
     task: [
        Task(title: "Talk to iJustine"),
        Task(title: "Talk to iJustine"),
        Task(title: "Talk to iJustine"),
        ],
     taskDate: getSampleData(offset: 0)
    ),
    TaskMetaData(
     task: [
        Task(title: "Talk to iJustine"),
        ],
     taskDate: getSampleData(offset: -3)
    ),
    TaskMetaData(
     task: [
        Task(title: "Talk to iJustine"),
        Task(title: "Talk to iJustine"),
        ],
     taskDate: getSampleData(offset: -8)
    ),
    
]
