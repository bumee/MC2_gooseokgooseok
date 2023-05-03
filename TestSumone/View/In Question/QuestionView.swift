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
    @EnvironmentObject var WaitingQuestionList : WaitingQuestionData

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("대기중")){
                    ForEach(WaitingQuestionList.questions, id: \.self) { Question in
                        NavigationLink(
                            destination: SelectedTalkView()
                        ){
                            QuestionNameView(text: "\(Question)")
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
                AddQuestionView(WaitingQuestionList: _WaitingQuestionList)
            })
        }
    }
}
