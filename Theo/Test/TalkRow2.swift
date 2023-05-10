//
//  TalkRow2.swift
//  Test
//
//  Created by 박상준 on 2023/04/28.
//

import SwiftUI

struct TalkRow2: View {
    var Date: String
    var Question: String
    
    var body: some View {
        VStack {
            HStack {
                Text(Date)
                    .font(.caption2)
                    .foregroundColor(Color(uiColor: .systemGray2))
                
                Spacer()
                
                
            }
            .padding(.bottom, -6)
            
            HStack {
                Text(Question)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.footnote)
                    .foregroundColor(Color(uiColor: .systemGray))
            }
        }
        .frame(height: 48)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16))
    }
}

struct TalkRow2_Previews: PreviewProvider {
    static var previews: some View {
        TalkRow2(Date: "05/24", Question: "지난 한 주 동안 당신의 삶에서 일어난 긍정적인 일들은 무엇입니까?")
    }
}
