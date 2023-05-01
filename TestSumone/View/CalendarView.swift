//
//  CustomDatePicker.swift
//  test
//
//  Created by moon on 2023/04/28.
//

import SwiftUI

struct CalendarView: View {
    @State var currentDate: Date;
    // Month update on arrow button clicks....
    @State var currentMonth: Int = 0
    
    var body: some View {
        VStack (spacing: 35){
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            HStack (spacing: 20){
                VStack(alignment: .leading, spacing:10){
                    Text(extraDate()[0]) // 2023
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(extraDate()[1])
                        .font(.title.bold())
                }
                Spacer(minLength: 0)
                Button {
                    withAnimation{
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                }
                Button {
                    withAnimation{
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
            }
            .padding(.horizontal)
            
            // day view
            HStack(spacing: 0){
                ForEach(days,id: \.self){ day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                    
                }
            }
            
            // dates
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()) { value in
                    CardView(value: value)
                }
            }
        }
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack{
            if value.day != -1 {
                Text("\(value.day)")
                    .font(.title3.bold())
            }
        }
        
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

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(currentDate: Date())
    }
}


extension Date {
    func getAllDates() -> [Date]{
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year,.month], from: self))!
        
        var range = calendar.range(of: .day, in: .month, for: startDate)!
        range.removeLast()
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day == 1 ? 0 : day, to: startDate)!
        }
    }
}
