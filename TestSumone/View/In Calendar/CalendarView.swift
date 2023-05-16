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
    @State private var isAddSheetPresented = false
    @State private var selectedTask: Task?
    
    @ObservedObject private var myTask: TaskManager = calendarManager
    
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
                                .padding(.top, 2)
                                .padding(.trailing, 16)
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(uiColor: .systemGreen))
                                .onTapGesture{
                                    currentMonth -= 1
                                }
                            
                            Image(systemName: "chevron.right")
                                .padding(.top, 2)
                                .font(.body)
                                .fontWeight(.semibold)
                                .foregroundColor(Color(uiColor: .systemGreen))
                                .onTapGesture{
                                    currentMonth += 1
                                }
                                .padding(.trailing, 12)
                        }
                        
                        // day view(mon, tue, wed, ...)
                        let columns = Array(repeating: GridItem(.flexible()), count: 7)
                        LazyVGrid(columns: columns) {
                            ForEach(days,id: \.self){ day in
                                Text(day)
                                    .font(.caption).bold()
                                    .foregroundColor(Color(uiColor: .systemGray2))
                            }
                        }
                        
                        // dates
                        LazyVGrid(columns: columns) {
                            ForEach(extractDate()) { value in
                                CardView(value: value)
                                    .background(
                                        Capsule()
                                            .fill(Color(uiColor: .systemGreen))
                                            .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                                            .position(x:19.5, y: 16)
                                    )
                                    .onTapGesture{
                                        currentDate = value.date
                                    }
                            }
                        }
                    }
                    
                    Section(header: Text("기념일")) {
                        let tasks = myTask.tasks[getCurrentMonthAsInt()] // 어떻게 수정하지?
                        
                        ForEach(tasks!) {task in
                            if isSameDay(date1: task.time, date2: currentDate) {
                                Button(){
                                    selectedTask = task
                                } label:{
                                    VStack(alignment: .leading, spacing: 0){
                                        Text(dateFormatter.string(from: task.time))
                                            .font(.footnote)
                                            .foregroundColor(Color(uiColor: .systemGray))
                                            .padding(.bottom, 6)
                                        Text(task.title)
                                    }
                                }
                                .sheet(item: $selectedTask){ task in
                                    TaskAddView(uuidStr: task.id, eventTitle: task.title, eventDate: task.time, isEditting: true)
                                }

                            }

                        }

                        .onDelete{ idx in
                            myTask.remove(getCurrentMonthAsInt(), idx)
                        }
                    }
                }
                .onChange(of: currentMonth) { newValue in
                    currentDate = getCurrentMonth()
                }
                .navigationTitle("가족 캘린더")
                .toolbar {
                    Button() {
                        self.isAddSheetPresented = true
                    } label: {
                        Image(systemName: "plus").bold()
                            .font(.footnote)
                        Text("추가")
                            .font(.footnote)
                            .fontWeight(.black)
                    }
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(16)
                    .sheet(isPresented: self.$isAddSheetPresented) {
                        TaskAddView(eventDate: currentDate)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        let tasks = myTask.tasks[getCurrentMonthAsInt()]! // 어떻게 수정하지?
        
        VStack{
            if value.day != -1{
                if let task = tasks.first(where: {task in
                    return isSameDay(date1: task.time, date2: value.date)
                }) {
                    
                    Text("\(value.day)")
                        .font(.title3)
                        .modifier(ColorFromDate(val: value, selectedDate: currentDate))
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
                        .modifier(ColorFromDate(val: value, selectedDate: currentDate))
                        .fontWeight(isSameDay(date1: value.date, date2: currentDate) ? .semibold : .regular)
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
        }
        .frame(height:40, alignment: .top)
        
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

struct ColorFromDate: ViewModifier {
    var val: DateValue
    var selectedDate: Date
    
    func body(content: Content) -> some View {
        // val.date == Date(), 날짜가 같아도 문제가 발생한다.
        // 한국시간에 맞추겠다고 val.date을 1시간 뺐기 때문이다.
        
        if isSameDate(val.date, Date()) && isSameDate(val.date, selectedDate) {
            content.foregroundColor(Color.white)
        }
        else if isSameDate(val.date, Date()){
            content.foregroundColor(Color.accentColor)
        }
        else if isSameDate(val.date, selectedDate){
            content.foregroundColor(Color.white)
        }
        else {
            content.foregroundColor(Color.black)
        }
    }
    func isSameDate(_ dateA: Date, _ dateB: Date) -> Bool {
        return Calendar.current.isDate(dateA, inSameDayAs: dateB)
    }
}
