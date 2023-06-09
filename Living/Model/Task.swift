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
        addTask(dateFrom(5, 8), "어버이날")
        addTask(dateFrom(5, 12), "우리딸 생일")
        addTask(dateFrom(5, 17), "등산동호회: 북한산, 저녁늦게 들어옴")
        addTask(dateFrom(5, 18), "엄마 염색")
        addTask(dateFrom(5, 26), "아빠 눈썹 예약")
        addTask(dateFrom(5, 28), "가족여행, 강릉")
        addTask(dateFrom(5, 29), "가족여행, 강릉")
        addTask(dateFrom(5, 30), "차보험 갱신")
        
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
    
    func updateTask(_ uuid: String, _ date: Date, _ title: String) {
        let events = calendarManager.tasks[getMonthFromDate(date)]!
        if let index = events.firstIndex(where: { $0.id == uuid }) {
            calendarManager.tasks[getMonthFromDate(date)]![index].title = title
            calendarManager.tasks[getMonthFromDate(date)]![index].time = date
        }
    }
    func remove(_ uuid: String, _ date: Date) {
        let events = calendarManager.tasks[getMonthFromDate(date)]!
        if let index = events.firstIndex(where: { $0.id == uuid }) {
            calendarManager.tasks[getMonthFromDate(date)]!.remove(at: index)
        }
    }
    
    func dateFrom(_ month: Int,_ day: Int) -> Date {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.year = calendar.component(.year, from: Date())
        return calendar.date(from: dateComponents)!
    }
    
    func getMonthFromDate(_ date: Date) -> Int {
        let calendar = Calendar.current
        
        
        let month = calendar.dateComponents([.month], from: date)
        
        return month.month!
    }
    
}


var calendarManager: TaskManager = TaskManager()
