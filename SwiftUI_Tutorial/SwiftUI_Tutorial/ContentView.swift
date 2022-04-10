//
//  ContentView.swift
//  SwiftUI_Tutorial
//
//  Created by TaeSoo Yoon on 2022/03/10.
//

import SwiftUI

struct ContentView: View {
    
    let emojis : [String] = ["🤖","👻","🤢" ,"😹","🤮","🥶","😡","😰","😱","🤔","💩","👺","👿","👽","👳🏻","🧓🏾","😵","🥵"]
    
    @State var emojiCount = 2
    
    var removeButton : some View {
        Button {
            if self.emojiCount > 0 {
                self.emojiCount -= 1
            }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    
    var addButton : some View {
        Button(action: {
            if self.emojiCount < self.emojis.count{
                self.emojiCount += 1
            }
        }, label: {
            Image(systemName: "plus.circle")
        })
    }
    
    var cardsViewWithHStack : some View {
        HStack(alignment:.center, spacing: 5, content: {
            ForEach.init(emojis[0..<emojiCount], id: \.self , content: { emoji in
                CardView( content: emoji)
            })
        }).foregroundColor(.red)
    }
    
    var columes : [GridItem] = Array(repeating: .init(.adaptive(minimum: 60, maximum: 100)), count: 1)
    //fix - size 고정
    //flexiable - 크기 변경 가능
    //adaptive - 하나의 그리드뷰에 최소 크기 부터 맥스 크기의 값을 넣는다.
    
    var cardsView : some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVGrid(columns: columes, content: {
                ForEach.init(emojis[0..<emojiCount], id: \.self , content: { emoji in
                    CardView( content: emoji).aspectRatio(2/3, contentMode: .fit)
                })
            })
        })
    }
    
    var body: some View {
        
        return VStack{
            self.cardsView
            Spacer(minLength: 10)
            HStack {
                self.addButton
                Spacer()
                self.removeButton
            }
            .font(.largeTitle)
            .padding(.horizontal)

        }.padding(.horizontal)
    }
}

struct CardView : View {
    
    //상태 프로퍼티 값이 변경되었다는 것은 그 프로퍼티가 선언된 뷰 계층구조를 다시 렌더링 해야 한다는 SwiftUI의 신호다
    @State
    private var isFaceUp : Bool = false//For Temporary use
    
    var content : String
    
    var body : some View {
        
        let view = ZStack{ //ZStack은 겹겹이 쌓아 올림
            
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                
                shape
                    .strokeBorder(lineWidth: 3) //내부로 경계선 생성
                    .foregroundColor(.blue)
                
                
                Text(content)
                    .font(.largeTitle)
            }
            else{
                shape
                    .fill()
                    .foregroundColor(.blue)
                
                shape.stroke(lineWidth: 3) //외부로 경계선 생성
                    .foregroundColor(.white)
                
                Text("")
                    .font(.largeTitle)
            }
            
            }
            .foregroundColor(.red)
            .onTapGesture(perform: {
                isFaceUp = !isFaceUp
            })
        
        return view
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
