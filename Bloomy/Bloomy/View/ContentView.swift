//
//  SwiftUIView.swift
//  Bloomy
//
//  Created by Mayara Mendonça de Souza on 05/12/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Home()
            .onAppear() {
                challenges = getAcceptedChallenges()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    
    @State var menu = 0
    @State var page = 1
    
    var body: some View {
        
        ZStack {
            
            Color("cor_fundo").edgesIgnoringSafeArea(.all)
            
            VStack {
                
                GeometryReader {card in
                    
                    // Simple Carousel List....
                    // Using GeomtryReader For Getting Remaining Height...
                    
                    Carousel(width: UIScreen.main.bounds.width, page: self.$page, height: card.frame(in: .global).height)
                }
                
                PageControl(page: self.$page)
                .padding(.top, 20)
            }
            .padding(.vertical)
        }
    }
}

struct List : View {
    
    @Binding var page : Int
    @State var acceptedChallenges = challenges
    var body: some View {
        
        HStack(spacing: 0) {
        
            ForEach(0..<acceptedChallenges.count, id: \.self) { index in
                // Mistakenly Used Geomtry Reader...
                
                Card(index: index, page: self.$page, width: UIScreen.main.bounds.width, challenge: acceptedChallenges[index])
            }
        }
        .onAppear() {
            acceptedChallenges = getAcceptedChallenges()
        }
    }
}

struct Card : View {
    var index: Int
    @Binding var page : Int
    var width : CGFloat
    var challenge: Challenge
    
    var body: some View {
        
        VStack {
            
            VStack {

                Spacer(minLength: 0)
                
                Image(islandNameToImage[challenge.challengeToIsland!.name!]!)
                .resizable()
                .cornerRadius(20)
                .aspectRatio(contentMode: .fit)
                
                Text(challenge.summary!)
                    .font(.custom("Poppins-Regular", size: 20))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30.0)
                    .padding(.top, -250)

                Button(action: {
                    self.challenge.done = true
                    ChallengeManager.shared.saveContext()
                }) {
                    Text("concluir missão")
                        .font(.custom("Poppins-Bold", size: 18))
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 30)
                }
                .background(Color("cor_botao"))
                .clipShape(Capsule())
                .padding(.top, -90)
            
                Spacer(minLength: 0)
                
                // For Filling Empty Space....
            }
            .padding(.horizontal, 40.0)
            .padding(.vertical, 25)
            .background(Color("cor_fundo"))
            .cornerRadius(20)
            .padding(.top, 25)
            .padding(.vertical, self.page == index ? 0 : 25)
            .padding(.horizontal, self.page == index ? 0 : 25)
            
            // Increasing Height And Width If Currnet Page Appears...
        }
        .frame(width: self.width)
        .animation(.default)
    }
}

struct Carousel : UIViewRepresentable {

    func makeCoordinator() -> Coordinator {
        
        return Carousel.Coordinator(parent1: self)
    }
    
    var width : CGFloat
    @Binding var page : Int
    var height : CGFloat
    
    func makeUIView(context: Context) -> UIScrollView {
        
        // ScrollView Content Size...
        
        let total = width * CGFloat(challenges.count)
        let view = UIScrollView()
        view.isPagingEnabled = true
        //1.0  For Disabling Vertical Scroll....
        view.contentSize = CGSize(width: total, height: 1.0)
        view.bounces = true
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.delegate = context.coordinator
        
        // Now Going to  embed swiftUI View Into UIView...
        
        let view1 = UIHostingController(rootView: List(page: self.$page))
        view1.view.frame = CGRect(x: 0, y: 0, width: total, height: self.height)
        view1.view.backgroundColor = .clear
        
        view.addSubview(view1.view)
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
    class Coordinator : NSObject,UIScrollViewDelegate {
        
        var parent : Carousel
        
        init(parent1: Carousel) {
        
            parent = parent1
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            
            // Using This Function For Getting Currnet Page
            // Follow Me...
            
            let page = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
            
            self.parent.page = page
        }
    }
}

// Now We GOing TO Implement UIPageControl...

struct PageControl : UIViewRepresentable {

    @Binding var page : Int

    func makeUIView(context: Context) -> UIPageControl {

        let view = UIPageControl()
        view.currentPageIndicatorTintColor = .black
        view.pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        view.numberOfPages = challenges.count
        return view
    }

    func updateUIView(_ uiView: UIPageControl, context: Context) {

        // Updating Page Indicator When Ever Page Changes....

        DispatchQueue.main.async {

            uiView.currentPage = self.page
        }
    }
}

struct Type : Identifiable {
    
    var id : Int
    var name : String
    var cName : String
    var image : String
}

var data = [

    Type(id: 0, name: "Atenção Plena", cName: "Passe um tempo observando o céu", image: "card_atencao_plena"),
    
    Type(id: 1, name: "Saúde", cName: "Faça uma caminhada", image: "card_saude"),
    
    Type(id: 2, name: "Pessoas Queridas", cName: "Faça uma chamada de vídeo com alguém que você ama", image: "card_pessoas_queridas"),
    
    Type(id: 3, name: "Lazer", cName: "Assista a um episódio da sua série favorita", image: "card_lazer")

]

var islandNameToImage: [String:String] = [
    "Atenção Plena": "card_atencao_plena",
    "Saúde": "card_saude",
    "Pessoas Queridas": "card_pessoas_queridas",
    "Lazer": "card_lazer"
]

var challenges = getAcceptedChallenges()

func getAcceptedChallenges() -> [Challenge] {
    var acceptedChallenges: [Challenge] = []
    for island in UserManager.shared.getIslands()! {
        if let dailyChallenge = island.dailyChallenge {
            if dailyChallenge.accepted && !dailyChallenge.done {
                acceptedChallenges.append(dailyChallenge)
            }
        }
    }
    return acceptedChallenges
}


//Link do Tutorial: https://www.youtube.com/watch?v=BK-8Ddtoa_w
