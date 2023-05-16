//
//  TaskAddView.swift
//  TestSumone
//
//  Created by moon on 2023/05/04.
//

import SwiftUI


struct TaskAddView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var uuidStr: String?
    @State var eventTitle: String = ""
    @State var eventDate: Date = Date()
    @State var isEditting: Bool = false
    @State var showActionSheet = false
    
    var eventRepo: TaskManager = calendarManager
    
    var body: some View {
        NavigationView() {
            VStack{
                List {
                    Section() {
                        DatePicker("날짜", selection: $eventDate, displayedComponents: [.date] )
                            .environment(\.locale, Locale(identifier: "ko_KR"))
                            .datePickerStyle(.compact)
                    }
                    Section(){
                        TextField("제목", text: $eventTitle)
                    }
                }
                if isEditting{
                    Button(action: {
                        showActionSheet = true
                    }, label: {
                        Image(systemName: "trash")
                    })
                    .foregroundColor(.red)
                    .actionSheet(isPresented: $showActionSheet) {
                        ActionSheet(
                            title: Text("삭제"), buttons: [
                                .destructive(Text("기념일 삭제"), action: {
                                    eventRepo.remove(uuidStr!, eventDate)
                                    presentationMode.wrappedValue.dismiss()
                                }),
                                .cancel(Text("취소"))
                            ]
                        )
                    }
                }
            }
            .navigationTitle("새로운 기념일")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        if !isEditting{
                            eventRepo.addTask(self.eventDate, self.eventTitle)
                        } else {
                            eventRepo.updateTask(self.uuidStr!, self.eventDate, self.eventTitle)
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Text(isEditting ? "수정" : "완료")
                    })
                    .disabled(self.eventTitle == "" ? true : false)
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
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
      TaskAddView(eventRepo: TaskManager())
  }
}
