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

/*
struct TaskMetaData: Identifiable {
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
}
 */

func getSampleData(offset: Int)->Date {
    let calendar = Calendar.current
    let date = calendar.date(byAdding:.day, value: offset, to: Date())
    
    return date ?? Date()
}

class TaskManager : ObservableObject {
    @Published var tasks: [Task] = []
    
    init() {
        tasks.append(Task(title: "hawing", time: Date()))
        tasks.append(Task(title: "hawing", time: getSampleData(offset: 0)))
        tasks.append(Task(title: "hawing", time: getSampleData(offset: 1)))
        tasks.append(Task(title: "hawing", time: getSampleData(offset: 2)))
        tasks.append(Task(title: "hawing", time: getSampleData(offset: 20)))
        tasks.append(Task(title: "hawing", time: getSampleData(offset: 30)))
    }
    
    func addTask(_ newTask: Task) {
        tasks.append(newTask)
    }
    
    
}

/*
 var tasks: [TaskMetaData] = []
 */
