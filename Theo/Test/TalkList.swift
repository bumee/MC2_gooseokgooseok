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
                
                ForEach(1..<10) {i in
                    NavigationLink {
                        TalkDetail()
                    } label: {
                        TalkRow2()
                    }
                }

            }
            .navigationTitle("대화")
        }
    }
}

struct listView_Previews: PreviewProvider {
    static var previews: some View {
        TalkList()
    }
}
