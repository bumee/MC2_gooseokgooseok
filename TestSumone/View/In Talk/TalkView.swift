//
//  TalkView.swift
//  TestSumone
//
//  Created by kibum on 2023/04/28.
//

import Foundation
import SwiftUI

struct TalkView: View {
    @EnvironmentObject var PreviousQuestions: PreviousQuestionData
    var userName: String
    @EnvironmentObject var TodayQuestions: TodayQuestionData
    
    private func WhereToGo(key: String) -> some View {
        if !TodayQuestions.real_questions[key]!.keys.contains(userName) {
            return AnyView(MessageBlockView(text: AnswerTextData(), Title: key, userName: userName, AnswerList: TodayQuestions.real_questions[key]!))
        }
        return AnyView(MessageShowingView(Title: key, MessageList: TodayQuestions.real_questions[key]!, userName: userName))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(TodayQuestions.real_questions.keys.sorted(), id: \.self) { key in
                    NavigationLink {
                        WhereToGo(key: key)
                    } label: {
                        TodayQuestionView(Question: key)
                            .cornerRadius(12)
                    }
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                
                Spacer()
                
                Section(header: Text("지난 대화")) {
                    ForEach(PreviousQuestions.questions.keys.sorted(), id: \.self) { key in
                        NavigationLink(
                            destination:  MessageShowingView(Title: key, MessageList: PreviousQuestions.questions[key]!, userName: userName)
                        )
                        {
                            PreviousQuestionNameView(Date: key, Question: key)
                        }
                        .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    }
                }
            }
//            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .navigationTitle("Talk")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            TodayQuestions.fetchTodayQuestions()
        }
    }
}
