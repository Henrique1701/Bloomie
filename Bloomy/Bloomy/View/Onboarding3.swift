//
//  Onboarding3.swift
//  Bloomy
//
//  Created by Wilton Ramos on 03/03/21.
//

import SwiftUI

struct Onboarding3: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var isMindfulnessSelected = false
    @State var isLovedsSelected = false
    @State var isLeisureSelected = false
    @State var isHealthSelected = false
    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack() {
                
                Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                    Image("botao_back")
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                }.frame(width: geometry.size.width * 0.9, alignment: .leading)
                
                Text("Quais áreas vamos cuidar?")
                    .font(.custom("Poppins-Medium", size: 30))
                    .foregroundColor(Color("cor_fonte"))
                    .padding(.trailing)
                    .frame(width: geometry.size.width * 0.9, alignment: .leading)
                
                Spacer()
                
                VStack() {
                    
                    Button(action: {
                        self.isMindfulnessSelected.toggle()
                    }) {
                        if !isMindfulnessSelected {
                            Image("botao_atencao_plena")
                                .resizable()
                                .scaledToFit()
                        } else {
                            Image("botao_on_atencao_plena")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.isLovedsSelected.toggle()
                    }) {
                        if !isLovedsSelected {
                            Image("botao_pessoas_queridas")
                                .resizable()
                                .scaledToFit()
                        } else {
                            Image("botao_on_pessoas_queridas")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.isLeisureSelected.toggle()
                    }) {
                        if !isLeisureSelected {
                            Image("botao_lazer")
                                .resizable()
                                .scaledToFit()
                        } else {
                            Image("botao_on_lazer")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        self.isHealthSelected.toggle()
                    }) {
                        if !isHealthSelected {
                            Image("botao_saude")
                                .resizable()
                                .scaledToFit()
                        } else {
                            Image("botao_on_saude")
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    
                }.frame(maxHeight: geometry.size.height * 0.55).frame(width: geometry.size.width * 0.85)
                
                Spacer()
                
                Button(action: {}) {
                    Text("vamos lá")
                        .font(.custom("Poppins-Bold", size: 18))
                        .foregroundColor(Color("cor_fonte"))
                        .padding(.vertical, geometry.size.height * 0.02)
                        .padding(.horizontal, geometry.size.width * 0.15)
                }
                .background(Color("cor_botao"))
                .clipShape(Capsule())
                
            }
            .padding(.bottom, geometry.size.height * 0.05)
            .frame(width: geometry.size.width)
        }
        .background(Color("cor_fundo").edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
    }
}

struct Onboarding3_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding3()
        Onboarding3()
            .previewDevice("iPhone 12 Pro Max")
        Onboarding3()
            .previewDevice("iPod touch (7th generation)")
    }
}
