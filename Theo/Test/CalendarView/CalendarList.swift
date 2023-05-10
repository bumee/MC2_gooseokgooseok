//
//  CalendarView.swift
//  Test
//
//  Created by 박상준 on 2023/05/02.
//

import SwiftUI

struct CalendarList: View {
    @State private var date = Date()
    @State private var showModal = false

    var body: some View {
        NavigationView() {
            List {
                Section {
                    DatePicker(
                        "Start Date",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                }
                
                Section(header: Text("그날의 기념일")) {
                    ForEach(1..<10) {i in
                        CalendarRow()
                    }
                }
                
            }
            .navigationTitle("캘린더")
            .toolbar {
                Button() {
                    self.showModal = true
                } label: {
                    Image(systemName: "plus").bold()
                        .font(.footnote)
                    Text("추가")
                        .font(.footnote)
                        .fontWeight(.black)
                }
                .buttonStyle(.borderedProminent)
                .cornerRadius(16)
                .sheet(isPresented: self.$showModal) {
                    QuestionAddModal()
                }
            }
            
            
        }
        
    }
}

struct CalendarVeiw_Previews: PreviewProvider {
    static var previews: some View {
        CalendarList()
    }
}
