//
//  DesafiosVazioView.swift
//  Bloomy
//
//  Created by Wilton Ramos on 10/12/20.
//

import SwiftUI

struct DesafiosVazioView: View {
    var body: some View {
        Color("cor_fundo")
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Spacer()
                    Image("garota_onboarding")
                        .resizable()
                        .frame(minWidth: 150, idealWidth: 275, minHeight: 150, idealHeight: 290, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    //Diminuir um pouco a imagem
                    
                    Text("Nenhum desafio em\n andamento")
                        .font(.custom("Poppins-Bold", size: 24))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                     
                    Spacer()
                        .frame(idealWidth: 30, maxWidth: 35, idealHeight: 30, maxHeight: 35)
                    
                    Text("Por enquanto você não tem nenhum desafio para concluir.\nQue tal checar suas ilhas, e tentar selecionar um novo desafio (:")
                        .font(.custom("Poppins-Regular", size: 18))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .padding(.leading)
                        .frame(width: 330)
                        .lineSpacing(2)
                    
                    Spacer()
                }
            )
    }
}

struct DesafiosVazioView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DesafiosVazioView()
            DesafiosVazioView()
                .previewDevice("iPhone SE (2nd generation)")
        }
    }
}
