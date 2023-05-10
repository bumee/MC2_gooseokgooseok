//
//  listView.swift
//  Test
//
//  Created by 박상준 on 2023/04/28.
//

import SwiftUI

struct question {
    var date: Date
    var question: String
    var answer: Array<String>
}


//에렌이 짜줌
//class QuestionManager {
//    var questions: Array<question> = []
//
//    init() {
//        let a = question(date: Date(), question: "좋아하는 영화는 무엇인가요?", answer: ["죽은 시인의 사회", "애애올"])
//        addQuestion(a)
//
//    }
//
//    func addQuestion(_ newQuestion: question) {
//        questions.append(newQuestion)
//    }
//
//    func removeQuestion() {
//        questions.remove(at: 0)
//    }
//}

enum InfoType {
    case date, question, answer
}

func QuestionInfo(index: Int, infoType: InfoType) -> Array<String> {
    
    let questiondata = [
        [
            "date": ["05/08"],
            "question": ["좋아하는 영화는 무엇인가요?"],
            "answer": ["죽은 시인의 사회", "애애올", "라라랜드", "어바웃 타임"]],
        [
            "date": ["05/07"],
            "question": ["좋아하는 색깔은 무엇인가요?"],
            "answer": ["주황", "초록", "하늘", "하양"]],
        [
            "date": ["05/06"],
            "question": ["당신을 기운나게 하는 것은 무엇인가요?"],
            "answer": ["노래, 실리카겔의", "돈", "어머니의 응원 한 마디", "룸메이트의 부재"]],
        [
            "date": ["05/05"],
            "question": ["살면서 꼭 해보고 싶은 것은?"],
            "answer": ["네바다주 사막 드라이브", "스카이다이빙", "남극 여행", "외국 체류"]],
        [
            "date": ["05/04"],
            "question": ["지금 가장 먹고 싶은 음식은 무엇인가요?"],
            "answer": ["생맥주", "타코야끼", "피자에 치즈 고구마 크러스트 추가", "버거킹 3단 신메뉴"]],
        [
            "date": ["05/03"],
            "question": ["하루중 가장 좋아하는 시간은 언제인가요?"],
            "answer": ["일 전부 끝나고 침대에 누울 때", "버거킹 신메뉴 검색할 때", "아침에 커피 마실 때", "저녁에 게임할 때"]],
        [
            "date": ["05/02"],
            "question": ["요즘 가장 자주 듣는 노래는 무엇인가요?"],
            "answer": ["아이묭-사랑을 전하고 싶다던가", "헤이즈-와스레나이", "혼네-미앤유", "오아시스-왓에버"]],
        [
            "date": ["05/01"],
            "question": ["공짜 여행이면 가고 싶은 곳은 어디인가요?"],
            "answer": ["캐나다", "독도", "중국 서안", "하와이"]]
    ]
    
    switch infoType {
    case InfoType.date:
        return questiondata[index]["date"]!
    case InfoType.question:
        return questiondata[index]["question"]!
        //    case InfoType.answer:
        //        return answer[index]
    default:
        return ["Error"]
    }
}

struct TalkList: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                
//                Divider()
                
                NavigationLink {
                    TalkDetail()
                } label: {
                    TalkRow()
                        .cornerRadius(12)
                }
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                
//                Divider()
                
//                HStack {
//                    Text("지난 대화")
//                        .font(.title).bold()
//
//                    Spacer()
//                }
//
//                Divider()
                
                Section() {
                    ForEach(0..<8) {i in
                        NavigationLink {
                            TalkDetail()
                        } label: {
//                            TalkRow2(Date: "05/24", Question: "안녕 세상")
                            TalkRow2(Date: QuestionInfo(index: i, infoType: InfoType.date)[0], Question: QuestionInfo(index: i, infoType: InfoType.question)[0])
                        }
                        if i < 7 {
                            Divider()
                        }
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 0))

            }
            .navigationTitle(
                Text("대화")
            )
//            .ignoresSafeArea(edges: [.leading, .trailing])
        }
    }
}

struct listView_Previews: PreviewProvider {
    static var previews: some View {
        TalkList()
    }
}
