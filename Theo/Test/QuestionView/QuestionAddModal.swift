//
//  QuestionAdd.swift
//  Test
//
//  Created by 박상준 on 2023/05/02.
//

import SwiftUI

struct QuestionAddModal: View {
    @State var customQuestion: String = ""
    
    var body: some View {
        NavigationView() {
            List {
                TextField("질문을 입력해주세요", text: $customQuestion, axis: .vertical)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .autocorrectionDisabled()
                
//                VStack {
//                    HStack {
//                        Button(action: {
//                            presentation.wrappedValue.dismiss()
//                        }, label: {
//                            Text("취소")
//                                .foregroundColor(.red)
//                        })
//
//                        Spacer()
//
//                        Button(action: {
//                            presentation.wrappedValue.dismiss()
//                        }, label: {
//                            Text("추가")
//                        })
//                    }
//                    .padding(.leading)
//                    .padding(.trailing)
//                    .padding(.top)
//
//                }
            }
            .navigationTitle("새로운 질문")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: {
                        
                    }, label: {
                        Text("완료")
                    })
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button(action: {
                        
                    }, label: {
                        Text("취소")
                    })
                }
                
                
            }
        }
        
    }
}

struct QuestionAdd_Previews: PreviewProvider {
    static var previews: some View {
        QuestionAddModal()
    }
}
