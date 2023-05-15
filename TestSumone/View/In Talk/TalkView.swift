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
            return AnyView(MessageBlockView(text: AnswerTextData(), Title: key, userName: userName, AnswerList: TodayQuestions.real_questions[key]!, date: TodayQuestions.real_questions_Date[key]!))
        }
        return AnyView(MessageShowingView(Title: key, MessageList: TodayQuestions.real_questions[key]!, userName: userName, date: TodayQuestions.real_questions_Date[key]!))
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
                
                Section() {
                    ForEach(PreviousQuestions.questions.keys.sorted(), id: \.self) { key in
                        
                        NavigationLink(
                            destination: MessageShowingView(Title: key, MessageList: PreviousQuestions.questions[key]!, userName: userName, date: PreviousQuestions.questions_Date[key]!)
                        )
                        {
                            PreviousQuestionNameView(date: PreviousQuestions.questions_Date[key]!, Question: key)
                                .cornerRadius(12)
                        }
                        
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                //Month Selector?
                HStack {
                    Spacer()
                    
                    Image(systemName: "chevron.left")
                        .padding()
                    
                    Text("5월").bold()
                        .padding()
                    
                    Image(systemName: "chevron.right")
                        .padding()
                        .hidden()
                    
                    Spacer()
                }
                .padding(.bottom, 16)
            }
            .navigationTitle("대화")
        }
        .onAppear {
            TodayQuestions.fetchTodayQuestions()
            PreviousQuestions.fetchPreviousQuestions()
        }
    }
}
