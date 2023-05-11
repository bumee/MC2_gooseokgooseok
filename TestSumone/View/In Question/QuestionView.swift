//
//  QuestionView.swift
//  TestSumone
//
//  Created by kibum on 2023/04/27.
//

import Foundation
import SwiftUI

struct QuestionView: View {
    let items = [1,2,3]
    @State private var isModalShown = false
    @EnvironmentObject var WaitingQuestionList: WaitingQuestionData
    var userName : String
    @EnvironmentObject var dataBase: DataManager

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("대기중")){
                    ForEach(WaitingQuestionList.WaitingQuestions[userName]?.reversed() ?? [String](), id:\.self) { Question in
                        NavigationLink(
                            destination:  QuestionEditingView(PreviousQuestion: Question, userName: userName, WillChangeQuestion: Question)
                        ){
                            WaitingQuestionNameView(text: "\(Question)")
                        }
                    }
                }
                
                Section(header: Text("과거의 질문")){
                    
                }
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .navigationTitle("Question")
            .navigationBarItems(trailing: Button(action: {
                self.isModalShown = true
            }){
                HStack{
                    Text("Add")
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isModalShown) {
                AddQuestionView(userName: userName)
            })
        }
        .onAppear {
            // 서버에 fetching하는 코드 필요
            WaitingQuestionList.fetchWaitingQuestions()
            print(WaitingQuestionList.WaitingQuestions)
        }
    }
}

