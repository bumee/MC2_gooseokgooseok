//
//  listView.swift
//  Test
//
//  Created by 박상준 on 2023/04/28.
//

import SwiftUI

struct TalkList: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    TalkDetail()
                } label: {
                    TalkRow()
                }
                NavigationLink {
                    TalkDetail()
                } label: {
                    TalkRow2(date: todayDate[0], qustion: qustion[0])
                        .frame(height: 40)
                }
                NavigationLink {
                    TalkDetail()
                } label: {
                    TalkRow2(date: todayDate[1], qustion: qustion[1])
                        .frame(height: 40)
                }
                NavigationLink {
                    TalkDetail()
                } label: {
                    TalkRow2(date: todayDate[2], qustion: qustion[2])
                        .frame(height: 40)
                }
                NavigationLink {
                    TalkDetail()
                } label: {
                    TalkRow2(date: todayDate[3], qustion: qustion[3])
                        .frame(height: 40)
                }
                NavigationLink {
                    TalkDetail()
                } label: {
                    TalkRow2(date: todayDate[4], qustion: qustion[4])
                        .frame(height: 40)
                }
                NavigationLink {
                    TalkDetail()
                } label: {
                    TalkRow2(date: todayDate[5], qustion: qustion[5])
                        .frame(height: 40)
                }
                NavigationLink {
                    TalkDetail()
                } label: {
                    TalkRow2(date: todayDate[6], qustion: qustion[6])
                        .frame(height: 40)
                }
                NavigationLink {
                    TalkDetail()
                } label: {
                    TalkRow2(date: todayDate[7], qustion: qustion[7])
                        .frame(height: 40)
                }
                NavigationLink {
                    TalkDetail()
                } label: {
                    TalkRow2(date: todayDate[8], qustion: qustion[8])
                        .frame(height: 40)
                }
            }
            .navigationTitle("가족 소통공간")
        }
    }
}

struct listView_Previews: PreviewProvider {
    static var previews: some View {
        TalkList()
    }
}
