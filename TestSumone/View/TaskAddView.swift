//
//  TaskAddView.swift
//  TestSumone
//
//  Created by moon on 2023/05/04.
//

import SwiftUI


struct TaskAddView: View {
    
    @State var anniName: String = ""
    @State var anniDate: Date = Date()
    @Binding var showModal : Bool
    
    var myTask: TaskManager
    
    var body: some View {
        NavigationView() {
            List {
                Section() {
                    DatePicker("날짜", selection: $anniDate, displayedComponents: [.date] )
                        .environment(\.locale, Locale(identifier: "ko_KR"))
                        .datePickerStyle(.compact)
                }
                Section(){
                    TextField("제목", text: $anniName)
                }
            }
            
            .navigationTitle("새로운 기념일")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        myTask.addTask(self.anniDate, self.anniName)
                        
                        self.showModal = false
                        
                    }, label: {
                        Text("완료")
                    })
                    .disabled(self.anniName == "" ? true : false)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        self.showModal = false
                    }, label: {
                        Text("취소")
                    })
                    .foregroundColor(Color.red)
                }
            }
        }
    }
}
