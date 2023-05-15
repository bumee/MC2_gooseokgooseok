//
//  TaskAddView.swift
//  TestSumone
//
//  Created by moon on 2023/05/04.
//

import SwiftUI


struct TaskAddView: View {
    
    @State var uuidStr: String?
    @State var anniName: String = ""
    @State var anniDate: Date = Date()
    @State var isEditting: Bool = false
    @Binding var showModal : Bool
    
    var myTask: TaskManager = calendarManager
    
    var body: some View {
        NavigationView() {
            VStack{
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
            }
            .navigationTitle("새로운 기념일")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        if !isEditting{
                            myTask.addTask(self.anniDate, self.anniName)
                        } else {
                            myTask.updateTask(self.uuidStr!, self.anniDate, self.anniName)
                        }
                        
                        self.showModal = false
                        
                    }, label: {
                        Text(isEditting ? "수정" : "완료")
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

struct TaskAddView_Previews: PreviewProvider {
  static var previews: some View {
      TaskAddView(showModal: .constant(false), myTask: TaskManager())
  }
}
