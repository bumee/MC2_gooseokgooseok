//
//  CustomDatePicker.swift
//  test
//
//  Created by moon on 2023/04/28.
//

import SwiftUI

struct CalendarView: View {
    @State var currentDate: Date = Date()
    // Month update on arrow button clicks....
    @State var currentMonth: Int = 0
    @State private var showModal = false
    
    @ObservedObject private var myTask: TaskManager = TaskManager()
    
    let dateFormatter : DateFormatter = DateFormatter()
    
    init(){
        currentDate = Date()
        dateFormatter.dateFormat = "MM/dd"
    }
    
    var body: some View {
        NavigationView() {
            
            VStack {
                
                List{
                    
                    VStack{
                        
                        let days: [String] = ["일", "월", "화", "수", "목", "금", "토"]
                        
                        HStack {
                            HStack {
                                Text("\(extraDate()[0])년") // 2023
                                Text("\(extraDate()[1])") // May
                            }
                            .fontWeight(.bold)
                            .padding(EdgeInsets(top: 16, leading: 12, bottom: 12, trailing: 0))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.left")
                                .padding(.trailing, 16)
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                                .onTapGesture{
                                    currentMonth -= 1
                                }
                            
                            Image(systemName: "chevron.right")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                                .onTapGesture{
                                    currentMonth += 1
                                }
                        }
                        
                        // day view(mon, tue, wed, ...)
                        let columns = Array(repeating: GridItem(.flexible()), count: 7)
                        LazyVGrid(columns: columns) {
                            ForEach(days,id: \.self){ day in
                                Text(day)
                                    .font(.subheadline).bold()
                                    .foregroundColor(Color(uiColor: .systemGray2))
                            }
                        }
                        
                        // dates
                        LazyVGrid(columns: columns) {
                            ForEach(extractDate()) { value in
                                CardView(value: value)
                                    .background(
                                        Capsule()
                                            .fill(Color.blue)
                                            .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                                            .position(x:19, y: 16)
                                    )
                                    .onTapGesture{
                                        currentDate = value.date
                                    }
                            }
                        }
                    }
                    
                    Section(header: Text("가까운 기념일")) {
                        let tasks = myTask.tasks[getCurrentMonthAsInt()] // 어떻게 수정하지?
                        let a = myTask.tasks[getCurrentMonthAsInt() % 12 + 1]
                        let b = myTask.tasks[getCurrentMonthAsInt() % 12 + 2]
                        
                        
                        ForEach(tasks!) {task in
                            
                            VStack(alignment: .leading, spacing: 0){
                                Text(dateFormatter.string(from: task.time))
                                    .font(.system(size: 12, weight: .light))
                                    .padding(.vertical, 2)
                                    // .background(Color.red.opacity(0.3))
                                Text(task.title)
                                    .font(.system(size: 24))
                            }
                        }
                    }
                }
                .onChange(of: currentMonth) { newValue in
                    currentDate = getCurrentMonth()
                }
                .navigationTitle("캘린더")
                .toolbar {
                    Button("추가") {
                        self.showModal = true
                    }
                    .sheet(isPresented: self.$showModal) {
                        TaskAddView(showModal: $showModal, myTask: myTask)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        let tasks = myTask.tasks[getCurrentMonthAsInt()]! // 어떻게 수정하지?
        
        if value.day == -1 { EmptyView() }
        else {
            
            VStack{
                if let task = tasks.first(where: {task in
                    return isSameDay(date1: task.time, date2: value.date)
                }) {
                    Text("\(value.day)")
                        .font(.title3)
                        .foregroundColor(isSameDay(date1: value.date, date2: Date()) ? .gray : .black)
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .black)
                        .fontWeight(isSameDay(date1: value.date, date2: currentDate) ? .semibold : .regular)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, -8)
                    
                    Circle()
                        .fill(isSameDay(date1:task.time, date2: self.currentDate) ? .white : .red)
                        .frame(width: 6, height: 6)
                }
                else{
                    Text("\(value.day)")
                        .font(.title3)
                        .foregroundColor(isSameDay(date1: value.date, date2: Date()) ? .gray : .black)
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .black)
                        .fontWeight(isSameDay(date1: value.date, date2: currentDate) ? .semibold : .regular)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
            .frame(height:40, alignment: .top)
            // .background(isSameDay(date1: value.date, date2: Date()) ? Color.red : Color.white.opacity(0))
        }
        //        .padding(.vertical, 8)
        
    }
    
    // checking dates...
    func isSameDay(date1: Date, date2: Date) -> Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    func isSameMonth(date1: Date, date2: Date) -> Bool{
        let calendar = Calendar.current
        return calendar.isDate(date1, equalTo: date2, toGranularity: .month)
    }
    
    // extracting year and month for display...
    func extraDate() ->[String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date())
        else { return Date()}
        
        return currentMonth
    }
    
    func getCurrentMonthAsInt() -> Int {
        let calendar = Calendar.current
        
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date())
        else { print("getCurrentMonthAsInt() is wrong"); return 1 }
        
        let monthAsInt = calendar.component(.month, from: currentMonth)
        
        return monthAsInt
    }
    
    func extractDate()-> [DateValue]{
        
        let calendar = Calendar.current
        
        // Getting current month Date
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap{ date -> DateValue in
            
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
        
    }
}


extension Date {
    func getAllDates() -> [Date]{
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            
            let nxtDay = calendar.date(byAdding: .day, value: day, to: startDate)!
            
            // 기본 시간은 utc 15시이다. gmt는 utc보다 9시간 뒤이다.
            // 여기서 문제가 발생한다.
            // 15 + 9 시은 24시이므로 하루가 오버플로우되는 일이 발생한다.
            // 그래서 1시간을 빼줘서 이 문제를 해결했다.
            return calendar.date(byAdding: .hour, value: -1, to: nxtDay)!
        }
    }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
      CalendarView()
  }
}
