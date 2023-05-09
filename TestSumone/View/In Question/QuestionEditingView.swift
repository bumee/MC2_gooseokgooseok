//
//  QuestionEditingView.swift
//  TestSumone
//
//  Created by kibum on 2023/05/03.
//

import Foundation
import SwiftUI

struct QuestionEditingView : View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataBase: DataManager
    @State var PreviousQuestion : String = ""
    @State var userName : String
    @State var WillChangeQuestion : String = ""
    @State private var showActionSheet = false
    @State private var isHidden = true
    
    var body: some View {

        ZStack {
            VStack {
                TextField("질문을 입력해주세요", text: $WillChangeQuestion, axis: .vertical)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .autocorrectionDisabled()
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                Button(action: {
                    showActionSheet = true
                }, label: {
                    Image(systemName: "trash")
                })
                .foregroundColor(.red)
            }
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("삭제"), buttons: [
                        .destructive(Text("메모 삭제"), action: {
                            // Delete the memo here
                            dataBase.WaitingQuestions.removeAll { $0 == PreviousQuestion }
                            dataBase.deleteWaitingQuestions(PersonName: userName, Statement: PreviousQuestion)
                            presentationMode.wrappedValue.dismiss()
                        }),
                        .cancel(Text("취소"))
                    ]
                )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar() {
            if WillChangeQuestion != PreviousQuestion {
                Button("완료") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .toolbar(isHidden ? .hidden : .visible, for: .tabBar)
        .onDisappear{
            if let idx = dataBase.WaitingQuestions.firstIndex(of: PreviousQuestion) {
                dataBase.WaitingQuestions[idx] = WillChangeQuestion
            }
            dataBase.fixWaitingQuestions(PersonName: userName, OrigianlStatement: PreviousQuestion, FixStatement: WillChangeQuestion)
            isHidden = false
        }
        //        .toolbar(.hidden, for: .tabBar)
            
    }
}

