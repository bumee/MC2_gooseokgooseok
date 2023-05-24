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
    
    @State private var searchText = ""
    
    private func WhereToGo(key: String) -> some View {
        if !TodayQuestions.real_questions[key]!.keys.contains(userName) {
            return AnyView(MessageBlockView(text: AnswerTextData(), Title: key, userName: userName, AnswerList: TodayQuestions.real_questions[key]!, date: TodayQuestions.real_questions_Date[key]!))
        }
        return AnyView(MessageShowingView(Title: key, MessageList: TodayQuestions.real_questions[key]!, userName: userName, date: TodayQuestions.real_questions_Date[key]!))
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                       
                ForEach(TodayQuestions.real_questions.keys.sorted().filter({ searchText.isEmpty || $0.localizedStandardContains(searchText)}), id: \.self) { key in
                    NavigationLink {
                        WhereToGo(key: key)
                    } label: {
                        TodayQuestionView(Question: key)
                            .cornerRadius(12)
                    }
                    .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                }
                .searchable(text: $searchText, prompt: "Search")
                
                Spacer()
                
                Section() {
                    ForEach(PreviousQuestions.sortedQuestions.filter({ searchText.isEmpty || $0.localizedStandardContains(searchText)}), id: \.self) { key in
                        
                        NavigationLink(
                            destination: MessageShowingView(Title: key, MessageList: PreviousQuestions.questions[key]!, userName: userName, date: PreviousQuestions.questions_Date[key]!)
                        )
                        {
                            PreviousQuestionNameView(date: PreviousQuestions.questions_Date[key]!, Question: key)
                        }
                        
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
            }
            .refreshable {
                TodayQuestions.fetchTodayQuestions()
                PreviousQuestions.fetchPreviousQuestions()
            }
            .navigationTitle("대화")
//            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            TodayQuestions.fetchTodayQuestions()
            PreviousQuestions.fetchPreviousQuestions()
        }
    }
}
