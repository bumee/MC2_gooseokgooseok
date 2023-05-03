//
//  QuestionAdd.swift
//  Test
//
//  Created by 박상준 on 2023/05/02.
//

import SwiftUI

struct QuestionAddModal: View {
    @State var customQuestion: String = ""
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        NavigationView() {
            List {
                TextField("질문을 입력해주세요", text: $customQuestion, axis: .vertical)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .autocorrectionDisabled()
            }
            .navigationTitle("새로운 질문")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("완료")
                    })
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Text("취소")
                    })
                    .foregroundColor(Color.red)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct QuestionAdd_Previews: PreviewProvider {
    static var previews: some View {
        QuestionAddModal()
    }
}
