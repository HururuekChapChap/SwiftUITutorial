//
//  VGrideView.swift
//  Combine_Publish_Test
//
//  Created by TaeSoo Yoon on 2022/06/07.
//

import SwiftUI

extension CGFloat {
    static var random: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random, green: .random, blue: .random, alpha: 1.0)
    }
}

struct Model : Identifiable {
    var id: Int
}

class VGrideViewModel : ObservableObject {
    @Published var items : [Model] = []
    
    func change(index : Int){
        items[index].id = Int.random(in: 0...50)
    }
    
    init(){
        for i in 0..<10 {
            items.append(Model(id: i))
        }
    }
    
}

struct VGrideView: View {

    /*
     1. GrideView 연습
     -> LazyVGrid라고 한다면 수직으로 생긴다.
     따라서 컬럼이 생기게 된다. 직 아이템들이 세로로 생기게 되는데,
     만약 GridItem이 세개라고 한다면
     1 2 3
     4 5 6
     순서로 생긴다.
     
     여기서 중요한 건 flexible이라는 건데, flexible은 값을 주지 않는다면
     만약 GrideItme이 세개라면
     화면을 세개로 나눠서 자신이 가질 수 있는 최대 화면 크기를 가지게 된다.
     
     adpative는 두개 이상 이라면 본인이 가질 수 있는 min값으로 공간을 채운다
     즉, GridItme이 세개라고 한다면
     하나의 GridItme이 100이라는 공간을 가질 수 있다면
     adaptive를 50으로 한다면 하나의 gridItem에 두개의 아이템이 생기게 된다.
     
     2. State변경 - ObservableObject
     @ObservedObject private var viewModel : VGrideViewModel
     로 설정해주면 viewModel안에 publish의 값이 변경 됐을 때 화면을 다시 그린다는 의미이다.
     
     참고 사이트 :
     
      - ObservableObject
     https://nsios.tistory.com/145
     https://nsios.tistory.com/120
     
     - GridItem
     https://swiftwithmajid.com/2020/07/08/mastering-grids-in-swiftui/
     https://seons-dev.tistory.com/58
     
     - ForEach에서 index 가져오는 방법
     https://stackoverflow.com/questions/57244713/get-index-in-foreach-in-swiftui
     
     */

//    private let layouts : [GridItem] = [
//        GridItem(.flexible()),
//        GridItem(.flexible()),
//        GridItem(.flexible())
//    ]
    
//    private let layouts : [GridItem] = [
//        GridItem(.adaptive(minimum: 50)),
//        GridItem(.adaptive(minimum: 50)),
//        GridItem(.adaptive(minimum: 100))
//    ]
    
    private let layouts : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.adaptive(minimum: 50))
    ]
    
    @ObservedObject private var viewModel : VGrideViewModel
    
    init(viewModel : VGrideViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: self.layouts, spacing: 16, pinnedViews: [.sectionHeaders , .sectionHeaders]) {
                
                Section {
                    ForEach(0..<self.viewModel.items.count, id: \.self) { index in
                        if index == 0 {
                            Text("Hello world sjdfkajflkjalfjakjfajfljalfjlajfklajfklajfkljalfj;laj;klasjfkljasfkljaslkfjaskljfkasjfkajslfksfjlsjfkljsfljklfjklasjflkjslfjlskjflkasjflkjasfkljsalkfjklsajfaklsdjkfjfksaljflkasjfkljaskfldjalfjlsajflkasjkfdjaksfljalskfjlaksjfklasjf;asfdja;lksfj \(self.viewModel.items[index].id)")
                                .foregroundColor(Color(UIColor.random))
                                .onTapGesture {
                                    viewModel.change(index: index)
                                print("Tap \(index)")
                            }
                        }
                        else{
                            Text("Hello world \(self.viewModel.items[index].id)")
                                .foregroundColor(Color(UIColor.random))
                        }
                        
                    }
                } header: {
                    Text("Section").font(.title)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.red)
                        .background(.indigo)
                }
                
                Section {
                    ForEach(["0","1","2","4","5","6"], id: \.self) { item in
                        if item == "0" {
                            Text("Hello world sjdfkajflkjalfjakjfajfljalfjlajfklajfklajfkljalfj;laj;klasjfkljasfkljaslkfjaskljfkasjfkajslfksfjlsjfkljsfljklfjklasjflkjslfjlskjflkasjflkjasfkljsalkfjklsajfaklsdjkfjfksaljflkasjfkljaskfldjalfjlsajflkasjkfdjaksfljalskfjlaksjfklasjf;asfdja;lksfj \(item)")
                                .foregroundColor(Color(UIColor.random))
                        }else{
                            Text("Hello world \(item)")
                                .foregroundColor(Color(UIColor.random))
                        }
                        
                    }
                } header: {
                    Text("Section2").font(.title)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.red)
                        .background(.indigo)
                }

            }
        }
    }
}

struct VGrideView_Previews: PreviewProvider {
    static var previews: some View {
        VGrideView(viewModel: VGrideViewModel())
    }
}
