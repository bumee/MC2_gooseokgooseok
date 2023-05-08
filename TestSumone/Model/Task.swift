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

class TaskManager : ObservableObject {
    @Published var tasks: [TaskMetaData] = [
        TaskMetaData(
         task: [
            Task(title: "Hello World!"),
            ],
         taskDate: getSampleData(offset: -3)
        ),
        TaskMetaData(
         task: [
            Task(title: "hawing"),
            Task(title: "spring boot"),
            ],
         taskDate: getSampleData(offset: -8)
        ),
    ]
    
    
    init() {
        tasks.append(
            TaskMetaData(
             task: [ Task(title: "Meeting with Tim cook"), Task(title: "Talk to iJustine"), ],
             taskDate: getSampleData(offset: 0)))
        tasks.append(
            TaskMetaData(
             task: [ Task(title: "Meeting with Tim cook"), Task(title: "Talk to iJustine"), ],
             taskDate: getSampleData(offset: -3)))
        tasks.append(
            TaskMetaData(
             task: [ Task(title: "Meeting with Tim cook"), Task(title: "Talk to iJustine"), ],
             taskDate: getSampleData(offset: -8)))
    }
    
    func addTask(_ taskData: TaskMetaData) {
        tasks.append(taskData)
    }
    
    
}

/*
 var tasks: [TaskMetaData] = []
 */
