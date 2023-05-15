//
//  SwiftUIView.swift
//  TestSumone
//
//  Created by moon on 2023/05/01.
//

import SwiftUI

struct Task: Identifiable, Comparable {
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
    
    static func <(lhs: Task, rhs: Task) -> Bool {
        return lhs.time < rhs.time
    }
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
    @Published var tasks : Dictionary<Int, Array<Task>> = [0:[], 1:[], 2:[], 3:[], 4:[], 5:[], 6:[], 7:[], 8:[], 9:[], 10:[], 11:[], 12:[]]
    
    init() {
        addTask(Date(), "hawing")
        addTask(getSampleData(offset: 2), "2222222")
        addTask(getSampleData(offset: 32), "3232323232")
        addTask(getSampleData(offset: 52), "52525252525252")
        addTask(getSampleData(offset: 72), "7272727272")
    }
    
    func addTask(_ date: Date, _ title: String) {
        let monthAsInt = Calendar.current.component(.month, from: date)
        
        let newTask = Task(title:title, time: date)
        
        tasks[monthAsInt]!.append(newTask)
        
        tasks[monthAsInt]!.sort()
    }
    
    func remove(_ month: Int, _ idx: IndexSet) {
        tasks[month]!.remove(atOffsets: idx)
    }
    
    
}


