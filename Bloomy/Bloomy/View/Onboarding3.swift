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
    @State var selectedCount: Int = 0
    
    let user = UserManager()
    let island = IslandManager()
    let defaults = UserDefaults.standard
    
    func increaseOrDiacreaseCount(forStatus: Bool) {
        if (forStatus) {
            self.selectedCount -= 1
        } else {
            self.selectedCount += 1
        }
    }
    
    func createIslands() {
        let usuario = self.user.getUser()
    
        guard self.island.newIsland(withName: "Lazer") != nil else { return }
        _ = self.island.setUser(islandName: "Lazer", user: usuario!)
        SeedDataBase.shared.createLeisureChallenges()
        SeedDataBase.shared.createLeisureRewards()
        
        guard IslandManager.shared.newIsland(withName: "Saúde") != nil else { return }
        _ = self.island.setUser(islandName: "Saúde", user: usuario!)
        SeedDataBase.shared.createHealthChallenges()
        SeedDataBase.shared.createHealthRewards()
        
        guard IslandManager.shared.newIsland(withName: "Atenção Plena") != nil else { return }
        _ = self.island.setUser(islandName: "Atenção Plena", user: usuario!)
        SeedDataBase.shared.createMindfulnessChallenges()
        SeedDataBase.shared.createMindfulnessRewards()
        
        guard IslandManager.shared.newIsland(withName: "Pessoas Queridas") != nil else { return }
        _ = self.island.setUser(islandName: "Pessoas Queridas", user: usuario!)
        SeedDataBase.shared.createLovedsChallenges()
        SeedDataBase.shared.createLovedsRewards()
    }
    
    func setIslansInUserDefaults() {
        defaults.set(self.selectedCount, forKey: "quantityIslands")
        
        defaults.set(self.isMindfulnessSelected, forKey: "selectedMindfulness")
        defaults.set(self.isLeisureSelected, forKey: "selectedLeisure")
        defaults.set(self.isHealthSelected, forKey: "selectedHealth")
        defaults.set(self.isLovedsSelected, forKey: "selectedLoveds")
    }

    
    var body: some View {
        
        GeometryReader { geometry in
            
            VStack() {
                
                Button(action: {self.presentationMode.wrappedValue.dismiss()}) {
                    Image("botao_back")
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                }.frame(width: geometry.size.width * 0.9, alignment: .leading)
                
                Spacer()
                    .frame(height: geometry.size.height * 0.03)
                
                Text("Quais áreas vamos cuidar?")
                    .font(.custom("Poppins-Medium", size: 30))
                    .foregroundColor(Color("cor_fonte"))
                    .padding(.trailing)
                    .frame(width: geometry.size.width * 0.9, alignment: .leading)
                
                Spacer()
                
                VStack() {
                    
                    Button(action: {
                        self.increaseOrDiacreaseCount(forStatus: isMindfulnessSelected)
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
                        self.increaseOrDiacreaseCount(forStatus: isLovedsSelected)
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
                        self.increaseOrDiacreaseCount(forStatus: isLeisureSelected)
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
                        self.increaseOrDiacreaseCount(forStatus: isHealthSelected)
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
                
                if !self.isMindfulnessSelected && !self.isHealthSelected && !self.isLeisureSelected && !self.isLovedsSelected {
                    Button(action: {}) {
                        Text("vamos lá")
                            .font(.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color("cor_fonte"))
                            .padding(.vertical, geometry.size.height * 0.02)
                            .padding(.horizontal, geometry.size.width * 0.15)
                    }
                    .background(Color("cor_botao"))
                    .opacity(0.2)
                    .clipShape(Capsule())
                    .disabled(true)
                } else {
                    Button(action: {
                        self.createIslands()
                        self.setIslansInUserDefaults()
                        self.defaults.set(true, forKey: DefaultsConstants.auxiliarToRootWindow.rawValue)
                        //Chama o storyboard
                        NotificationCenter.default.post(name: Notification.Name("callHome"), object: nil)
                    }) {
                        Text("vamos lá")
                            .font(.custom("Poppins-Bold", size: 18))
                            .foregroundColor(Color("cor_fonte"))
                            .padding(.vertical, geometry.size.height * 0.02)
                            .padding(.horizontal, geometry.size.width * 0.15)
                    }
                    .background(Color("cor_botao"))
                    .clipShape(Capsule())
                }

            }
            .padding(.bottom, geometry.size.height * 0.05)
            .padding(.top, geometry.size.height * 0.025)
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
