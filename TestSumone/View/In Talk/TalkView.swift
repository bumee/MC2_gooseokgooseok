//
//  TalkView.swift
//  TestSumone
//
//  Created by kibum on 2023/04/28.
//

import Foundation
import SwiftUI

struct TalkView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: DetailView()) {
                    Image(systemName: "star")
                    Text("오늘의 학식은 ~~ 무엇일까요!?")
                        .font(.headline)
                        .bold()
                }
                NavigationLink(destination: AnotherView()) {
                    Text("Go to Another View")
                }
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .navigationTitle("Talk")
        }
    }
}
