//
//  TalkAnswerList.swift
//  Test
//
//  Created by 조용현 on 2023/05/04.
//

import SwiftUI

struct TalkAnswerList: View {
    
    @State var mom: Bool = true
    @State var dad: Bool = true
    @State var son: Bool = true
    
    var body: some View {
        Form {
            Text("04/21")
                .listRowSeparator(.hidden)
            Text("가장 소중하게 여기는 우리 가족의 추억은 뭔가요?")
        }
    }
}

struct TalkAnswerList_Previews: PreviewProvider {
    static var previews: some View {
        TalkAnswerList()
    }
}
