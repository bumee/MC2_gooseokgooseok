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
    @EnvironmentObject var WaitingQuestionLists: WaitingQuestionData
    @EnvironmentObject var Emojis : EmojiList
    @EnvironmentObject var dataBase : DataManager
    
    @State var userName: String = ""
    @State var isLoggedIn : Bool
    @State var SelectedEmojiIdx : Int
    @State var shouldShowNextView: Bool = false
    
    var body: some View {
        if isLoggedIn {
            NavigationView {
                TabView {
                    TalkView(userName: userName)
                        .tabItem {
                            Label("대화", systemImage: "message")
                        }
                        .tag(0)
                    QuestionView(userName: userName)
                        .tabItem {
                            Label("질문", systemImage: "plus.message.fill")
                        }
                        .tag(1)
                    CalendarView()
                        .tabItem {
                            Label("캘린더", systemImage: "calendar")
                        }
                        .tag(2)
                }
            }
            .toolbar(.hidden, for: .navigationBar)
            .onAppear {
                dataBase.addPerson(PersonName: userName, Emoji: Emojis[SelectedEmojiIdx], WaitingQuestionList: Array([String]()))
                dataBase.fetchPersons()
                questions.fetchPreviousQuestions()
            }
        }
        else {
            NavigationView {
                if !shouldShowNextView {
                    VStack {
                        HStack {
                            Image(systemName: "1.circle")
                                .foregroundColor(Color.accentColor)
                            
                            Image(systemName: "2.circle")
                                .foregroundColor(Color(uiColor: .systemGray3))
                            
                            Spacer()
                        }
                        .padding(.bottom, 24)
                        
                        Text("나는 우리 가족의 ____ 입니다.").bold()
                            .font(.largeTitle)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        TextField("별명을 입력해주세요", text: $userName)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .autocorrectionDisabled()
                            .padding()
                            .background(Color(uiColor: .secondarySystemBackground))
                            .cornerRadius(12)
                            .submitLabel(.next)
                            .onSubmit {
                                shouldShowNextView = true
                            }
                        
                        Spacer()
                        
                        NavigationLink(destination: LoginEmojiView(emojiList: _Emojis, userName: userName)){
                            Text("다음").bold()
                                .frame(maxWidth: .infinity, maxHeight: 60)
                                .background(userName != "" ? Color.accentColor : Color(uiColor: .secondarySystemBackground))
                                .foregroundColor(userName != "" ? .white : .gray)
                                .cornerRadius(16)
                        }
                        .disabled(userName == "")
                    }
                    .padding()
                }
                
                else {
                    LoginEmojiView(emojiList: _Emojis, userName: userName)
                }
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
