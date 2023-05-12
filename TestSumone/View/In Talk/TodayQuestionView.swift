//
//  TalkRow.swift
//  Test
//
//  Created by 박상준 on 2023/04/28.
//

import SwiftUI

struct TodayQuestionView: View {
    @EnvironmentObject var TodayQuestion: TodayQuestionData
    var Question: String
    var body: some View {
        VStack {
//            if TodayQuestion.real_qeustions_bool[Question] == false {
//                HStack{
//                    Circle()
//                        .frame(width: 8)
//                        .foregroundColor(.red)
//
//                    Spacer()
//                }
//                .padding(.top, 8)
//                .padding(.bottom, 6)
//            }
            
            HStack {
                Text("오늘")
                    .font(.footnote).bold()
                    .foregroundColor(Color(uiColor: .white))
                //                    .foregroundColor(Color(uiColor: .black))
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.footnote).bold()
                    .foregroundColor(Color(uiColor: .white))
                //                    .foregroundColor(Color(uiColor: .black))
            }
            .padding(.bottom, -4)
            
            HStack {
                Text(Question)
                    .font(.title).bold()
                    .foregroundColor(.white)
                //                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(-4)
                Spacer()
            }
        }
        .padding()
        .cornerRadius(12)
        .background(Color(uiColor: .systemGreen))
    }
}
