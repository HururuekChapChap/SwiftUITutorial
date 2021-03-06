//
//  ContentView.swift
//  SwiftUI_Tutorial
//
//  Created by TaeSoo Yoon on 2022/03/10.
//

import SwiftUI
#if false
struct ContentView: View {
    
    let emojis : [String] = ["๐ค","๐ป","๐คข" ,"๐น","๐คฎ","๐ฅถ","๐ก","๐ฐ","๐ฑ","๐ค","๐ฉ","๐บ","๐ฟ","๐ฝ","๐ณ๐ป","๐ง๐พ","๐ต","๐ฅต"]
    
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
    //fix - size ๊ณ ์ 
    //flexiable - ํฌ๊ธฐ ๋ณ๊ฒฝ ๊ฐ๋ฅ
    //adaptive - ํ๋์ ๊ทธ๋ฆฌ๋๋ทฐ์ ์ต์ ํฌ๊ธฐ ๋ถํฐ ๋งฅ์ค ํฌ๊ธฐ์ ๊ฐ์ ๋ฃ๋๋ค.
    
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
    
    //์ํ ํ๋กํผํฐ ๊ฐ์ด ๋ณ๊ฒฝ๋์๋ค๋ ๊ฒ์ ๊ทธ ํ๋กํผํฐ๊ฐ ์ ์ธ๋ ๋ทฐ ๊ณ์ธต๊ตฌ์กฐ๋ฅผ ๋ค์ ๋ ๋๋ง ํด์ผ ํ๋ค๋ SwiftUI์ ์ ํธ๋ค
    @State
    private var isFaceUp : Bool = false//For Temporary use
    
    var content : String
    
    var body : some View {
        
        let view = ZStack{ //ZStack์ ๊ฒน๊ฒน์ด ์์ ์ฌ๋ฆผ
            
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if isFaceUp {
                shape
                    .fill()
                    .foregroundColor(.white)
                
                shape
                    .strokeBorder(lineWidth: 3) //๋ด๋ถ๋ก ๊ฒฝ๊ณ์  ์์ฑ
                    .foregroundColor(.blue)
                
                
                Text(content)
                    .font(.largeTitle)
            }
            else{
                shape
                    .fill()
                    .foregroundColor(.blue)
                
                shape.stroke(lineWidth: 3) //์ธ๋ถ๋ก ๊ฒฝ๊ณ์  ์์ฑ
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

#endif

struct CardView : View {
    let card : MemoryGame<String>.Card
    
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 20)
            
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3).foregroundColor(.blue)
                Text(card.content).font(.largeTitle)
            }
            else{
                shape.fill().foregroundColor(.blue)
                
                shape.stroke(lineWidth: 3) //์ธ๋ถ๋ก ๊ฒฝ๊ณ์  ์์ฑ
                    .foregroundColor(.white)
                
                Text("").font(.largeTitle)
            }
        }
        .foregroundColor(.red)
    }
}

struct ContentView: View {
 
    //ํด๋น ๊ฐ์ฒด์ ๋ณํ๋ฅผ ๊ฐ์ํ๊ณ  ์๋ค.
    @ObservedObject var viewModel : EmojiMemoryGame
    
    var body: some View {
        VStack{
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 60, maximum: 100))], content: {
                    ForEach(viewModel.card , content: { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                    })
                })
            }
            .foregroundColor(.red)
        }
        .padding(.horizontal)
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
    }
}
