//
//  ContentView.swift
//  TestSumone
//
//  Created by kibum on 2023/04/27.
//

//import SwiftUI
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}

import SwiftUI
import Firebase

struct MainView: View {
    @State private var selection = 0
    @EnvironmentObject var questions: PreviousQuestionData
    @State var WaitingQuestionList : [String] = []
    @EnvironmentObject var Emojis : EmojiList
    @EnvironmentObject var dataBase : DataManager
    
    @State var userName: String = ""
    @State var isLoggedIn : Bool
    @State var SelectedEmojiIdx : Int
    
    var body: some View {
        if isLoggedIn {
            NavigationView {
                TabView {
                    TalkView(userName: userName)
                        .tabItem {
                            Text("Talk")
                                .font(.largeTitle)
                        }
                        .tag(0)
                    QuestionView(WaitingQuestionList: dataBase.WaitingQuestions, userName: userName)
                        .tabItem {
                            Text("Question")
                                .font(.largeTitle)
                        }
                        .tag(1)
                    CalendarView()
                        .tabItem {
                            Text("Calendar")
                                .font(.largeTitle)
                        }
    
                        .tag(2)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .onAppear {
                WaitingQuestionList = dataBase.fetchWaitingQuestions(PersonName: userName)
                dataBase.addPerson(PersonName: userName, Emoji: Emojis[SelectedEmojiIdx], WaitingQuestionList: Array(WaitingQuestionList))
                dataBase.fetchPersons()
                questions.fetchPreviousQuestions()
            }
        }
        else {
            NavigationView {
                VStack {
                    HStack {
                        Image(systemName: "1.circle")
                            .foregroundColor(Color.blue)
                        
                        Image(systemName: "2.circle")
                            .foregroundColor(Color(uiColor: .systemGray3))
                        
                        Spacer()
                    }
                    .padding(.bottom, 24)
                    
                    Text("나는 우리 가족의 ____ 입니다.").bold()
                        .font(.largeTitle)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("별명을 입력해주세요", text: $userName, axis: .vertical)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .autocorrectionDisabled()
                        .padding()
                        .background(Color(uiColor: .secondarySystemBackground))
                        .cornerRadius(12)
                    
                    Spacer()
                    
                    NavigationLink(destination: LoginEmojiView(emojiList: _Emojis, userName: userName)){
                        Text("다음").bold()
                            .frame(maxWidth: .infinity, maxHeight: 40)
                            .buttonStyle(.borderedProminent)
                    }
                }
                .padding()
            }
        }
    }
}

struct DetailView: View {
    var body: some View {
        Text("Detail View")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
            .navigationTitle("Detail View")
    }
}

struct AnotherView: View {
    var body: some View {
        Text("Another View")
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding()
            .navigationTitle("Another View")
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(userName: "데키", isLoggedIn: false, SelectedEmojiIdx: 0)
    }
}
