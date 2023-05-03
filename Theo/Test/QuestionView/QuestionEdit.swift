//
//  QuestionEdit.swift
//  Test
//
//  Created by 박상준 on 2023/05/02.
//

import SwiftUI
import UIKit

struct QuestionEdit: View {
    @Environment(\.presentationMode) var presentation
    @State var customQuestion: String = "지난 한 주 동안 당신의 삶에서 일어난 긍정적인 일들은 무엇입니까?"
    
    var body: some View {
        ZStack {
            VStack {
                TextField("질문을 입력해주세요", text: $customQuestion, axis: .vertical)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .autocorrectionDisabled()
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "trash")
                })
                .foregroundColor(.red)
            }
            
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar() {
            Button("완료") {
                
            }
        }
//        .toolbar(.hidden, for: .tabBar)
    
    }
}

struct QuestionEdit_Previews: PreviewProvider {
    static var previews: some View {
        QuestionEdit()
    }
}
