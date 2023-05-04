//
//  TaskAddView.swift
//  TestSumone
//
//  Created by moon on 2023/05/04.
//

import SwiftUI


struct TaskAddView: View {
    
    @State var anni_name: String = ""
    @State var anni_date: Date = Date()
    @Binding var showModal : Bool
    
    var myTask: TaskManager
    
    var body: some View {
        NavigationView() {
            List {
                Section() {
                    DatePicker("날짜", selection: $anni_date, displayedComponents: [.date] )
                }
                Section(){
                    TextField("제목", text: $anni_name)
                }
            }
            
            .navigationTitle("새로운 기념일")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        var task = Task(title: self.anni_name, time: anni_date)
                        var taskMetaData = TaskMetaData(task: [task], taskDate: anni_date)
                        
                        myTask.addTask(taskMetaData)
                        
                        self.showModal = false
                        
                    }, label: {
                        Text("완료")
                    })
                    .disabled(self.anni_name == "" ? true : false)
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

/*
 struct TaskAddView_Previews: PreviewProvider {
 static var previews: some View {
 TaskAddView(showModal: true, myTask: TaskManager())
 }
 }
 */
