//
//  ContentView.swift
//  SwiftUI_Tutorial
//
//  Created by TaeSoo Yoon on 2022/03/10.
//

import SwiftUI

struct ContentView: View {
    
    let emojis : [String] = ["🤖" , "👻"]
    
    var body: some View {
        let horizontal = HStack{
            
            ForEach.init(emojis, id: \.self , content: { emoji in
                CardView( content: emoji)
            })
            
        }
        return horizontal
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
                    .stroke(lineWidth: 4)//border를 생성해줌
                    .fill() //stroke의 View의 색을 foreGround로 채우게 된다.
                    .foregroundColor(.blue)
                
                shape
                    .fill()
                    .foregroundColor(.white)
                
                Text(content)
                    .font(.largeTitle)
            }
            else{
                shape
                    .fill()
                    .foregroundColor(.blue)
            }
            
            }
            .padding(.horizontal)
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
