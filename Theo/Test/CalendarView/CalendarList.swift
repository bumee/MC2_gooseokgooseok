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
                
                Section(header: Text("가까운 기념일")) {
                    ForEach(1..<10) {i in
                        CalendarRow()
                    }
                }
                
            }
            .navigationTitle("캘린더")
            .toolbar {
                Button("추가") {
                    self.showModal = true
                }
                .sheet(isPresented: self.$showModal) {
                    CalendarAddModal()
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
