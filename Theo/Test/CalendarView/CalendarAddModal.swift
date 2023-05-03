//
//  CalendarAddModal.swift
//  Test
//
//  Created by 박상준 on 2023/05/02.
//

import SwiftUI

struct CalendarAddModal: View {
    @Environment(\.presentationMode) var presentation
    @State private var wakeUp = Date()
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Text("취소")
                        .foregroundColor(.red)
                })
                
                Spacer()
                
                Button(action: {
                    presentation.wrappedValue.dismiss()
                }, label: {
                    Text("추가")
                })
            }
            .padding(.leading)
            .padding(.trailing)
            .padding(.top)
            
            HStack {
                Text("기념일 추가하기").bold()
                    .font(.largeTitle)
                    .padding(.leading)
                    .padding(.top, 1)
                    .padding(.bottom, 1)
                
                    Spacer()
            }
            
            Divider()
            
            DatePicker("기념일 선택", selection: $wakeUp, displayedComponents: .date)
                .padding()

            
            
            
            Spacer()
        }
    }
}

struct CalendarAddModal_Previews: PreviewProvider {
    static var previews: some View {
        CalendarAddModal()
    }
}
