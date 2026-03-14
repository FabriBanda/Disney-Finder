//
//  HomeScreen.swift
//  DisneyFinder
//
//  Created by Fabricio Banda on 08/03/26.
//

import SwiftUI

struct HomeScreen: View {
    
    @State private var homeViewModel:HomeViewModel
    @State private var nameCharacter:String = ""
    @State private var autoDismissTask: Task<Void, Never>?
    
    init(getAllCharactersUseCase: GetAllCharactersUseCase,searchCharactersUseCase:SearchCharacterUseCase) {
        _homeViewModel = State(wrappedValue: HomeViewModel(getAllCharactersUseCase: getAllCharactersUseCase, searchCharactersUseCase: searchCharactersUseCase))
    }
    
    private var isEmpty:Bool{
        return nameCharacter.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    }
    
    var body: some View {
        
        ZStack{
            Background()
            VStack(alignment: .leading){
                
                
                Image(.disneyLogo)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 70)
                
                HStack{
                    TextField("Mickey Mouse...", text: self.$nameCharacter)
                        .foregroundStyle(Color.white)
                        .font(.body)
                        .padding(10)
                        .background(Color.gray.opacity(0.2),in:RoundedRectangle(cornerRadius: 25))
                        .autocorrectionDisabled()
                    
                    Spacer()
                    
                    SearchButton(disable: self.isEmpty || self.homeViewModel.isLoading) {
                        Task{
                            await self.homeViewModel.searchCharacters(self.nameCharacter)
                        }
                    }
                }
                
                if self.homeViewModel.isLoading || !self.homeViewModel.displayed.isEmpty {
                    ScrollView{
                        LazyVStack(spacing: 15){
                            if self.homeViewModel.isLoading {
                                ForEach(0..<self.homeViewModel.skeletonCount, id: \.self) { _ in
                                    SkeletonCharacterRowView()
                                }
                            } else {
                                ForEach(self.homeViewModel.displayed,id:\._id) { character in
                                    CharacterRowView(name: character.name, imageUrl: character.imageUrl, films: character.films)
                                }
                            }
                        }
                    }.scrollIndicators(.hidden)
                }
                Spacer()
                
                switch self.homeViewModel.homeState {
                    
                case .notFound:
                    CharacterNotFound()
                default:
                    EmptyView()
                }
                
                Spacer()
                
                if !self.homeViewModel.isLoading {
                    Button {
                        self.nameCharacter = ""
                        Task{
                            await self.homeViewModel.getAllCharacters()
                        }
                    } label: {
                        HStack{
                            Spacer()
                            Text("Get all characters")
                                .foregroundStyle(Color.white)
                                .font(.body)
                                .bold(true)
                            Spacer()
                        }
                        
                    }
                    .padding(10)
                    .background(Color.black.opacity(0.3),in:RoundedRectangle(cornerRadius: 25))
                    .padding(.horizontal)
                }
                
            }
            .animation(.linear,value: self.homeViewModel.isLoading)
            .animation(.bouncy, value: self.isEmpty)
            .foregroundStyle(Color.white)
            .background(Color.clear)
            .padding(.horizontal)
            .overlay(alignment: .top){
                if let visibleError = homeViewModel.visibleError{
                    AlertError(messageError: visibleError.message) {
                        dismissError()
                    }
                    .padding()
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .onAppear{
                        self.presentError()
                    }
                }
            }
            .animation(.bouncy, value: self.homeViewModel.visibleError)
            .onDisappear {
                self.autoDismissTask?.cancel()
            }
        }
        
    }
    
    private func presentError() {
        self.autoDismissTask?.cancel()
        self.autoDismissTask = Task {
            try? await Task.sleep(for: .seconds(3))
            guard !Task.isCancelled else { return }
            self.dismissError()
        }
    }

    private func dismissError() {
        self.autoDismissTask?.cancel()
        self.autoDismissTask = nil
        self.homeViewModel.clearVisibleError()
    }
}

