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

struct MainView: View {
    @State private var selection = 0

    var body: some View {
        TabView {
            TalkView()
                .tabItem {
                    Text("Talk")
                        .font(.largeTitle)
                }
                .tag(0)
            Text("Second View")
                .tabItem {
                    Text("Question")
                        .font(.largeTitle)
                }
                .tag(1)
            Text("Third View")
                .tabItem {
                    Text("Calendar")
                        .font(.largeTitle)
                }
                .tag(2)
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
        MainView()
    }
}
