//
//  QuestionAdd.swift
//  Test
//
//  Created by 박상준 on 2023/05/02.
//

import SwiftUI

struct QuestionAddModal: View {
    @Environment(\.presentationMode) var presentation
    
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
                Text("질문 추가하기").bold()
                    .font(.largeTitle)
                    .padding(.leading)
                    .padding(.top, 1)
                    .padding(.bottom, 1)
                
                    Spacer()
            }
            
            Divider()
            
            Text("여기에 입력하기")
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            
            Spacer()
        }
    }
}

struct QuestionAdd_Previews: PreviewProvider {
    static var previews: some View {
        QuestionAddModal()
    }
}
