//
//  Onboarding.swift
//  Bloomy
//
//  Created by Wilton Ramos on 26/02/21.
//
import SwiftUI

struct Onboarding: View {
    var body: some View {
        
        NavigationView {
            
            GeometryReader { geometry in
                VStack() {
                    
                    Image("garota_onboarding")
                        .resizable()
                        .scaledToFit()
                        .frame(idealWidth: 409, maxWidth: 600,idealHeight: 402, maxHeight: geometry.size.height * 0.5)
                    
                    Text("Como vai?")
                        .font(.custom("Poppins-SemiBold", size: 34))
                        .foregroundColor(Color("cor_fonte"))
                        
                    Spacer()
                        .frame(maxHeight: 20)
                    
                    Text("Acreditamos que pequenas ações\n conseguem mudar o mundo")
                        .frame(width: geometry.size.width * 0.9)
                        .font(.custom("Poppins-Regular", size: 18))
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color("cor_fonte"))
                    
                    Spacer(minLength: 40)
                    
                    NavigationLink(
                        destination: Onboarding2(),
                        label: {
                            Text("começar")
                                .font(.custom("Poppins-Bold", size: 18))
                                .foregroundColor(Color("cor_fonte"))
                                .padding(.vertical, geometry.size.height * 0.02)
                                .padding(.horizontal, geometry.size.width * 0.15)
                        })
                        .background(Color("cor_botao"))
                        .clipShape(Capsule())

                }
                .padding(.bottom, geometry.size.height * 0.05)
            }.background(Color("cor_fundo").edgesIgnoringSafeArea(.all))
            .navigationBarHidden(true)
        }
        
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Onboarding()
            Onboarding()
                .previewDevice("iPhone SE (2nd generation)")
            Onboarding()
                .previewDevice("iPod touch (7th generation)")
            
        }
    }
}
