//
//  CharacterListViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 01.10.2024.
//

import Foundation


class CharacterListViewModel : ViewModel {
    private let interactor: RickAndMortyInteractor
    
    init(interactor: RickAndMortyInteractor) {
        self.interactor = interactor
    }
    
    @Published internal var errorMessage: FailureError?
    @Published var name: String = ""
    
    func fetchCharacterList() {
        doTask(interactor.fetchCharacterList.self) { [weak self] result in
            print("Fetched data: \(result)")
            
            self?.name = result.list.first?.name ?? "Default"
        }
    }
    
    deinit {
        print("deleted")
    }
}
