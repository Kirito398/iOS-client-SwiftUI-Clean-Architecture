//
//  CharacterDetailUIConverters.swift
//  RickAndMortyAPI
//
//  Created by Ilgiz Sultanbekov on 16.10.2024.
//

import SwiftUI

extension CharacterDetail {
    func mapToUIModel() -> CharacterDetailUI {
        CharacterDetailUI(
            id: self.id,
            name: self.name,
            status: self.status.mapToUIModel(),
            species: self.species,
            type: self.type,
            gender: self.gender.mapToUIModel(),
            image: self.image,
            avatar: self.avatar.mapToUiModel(),
            origin: self.origin.mapToUIModel(),
            location: self.location.mapToUIModel()
        )
    }
}

extension CharacterDetail.Origin {
    func mapToUIModel() -> CharacterDetailUI.Origin {
        switch self {
        case .unknown: CharacterDetailUI.Origin.unknown
        case .named(let id, let name): CharacterDetailUI.Origin.named(id: id, name: name)
        }
    }
}

extension CharacterDetail.Location {
    func mapToUIModel() -> CharacterDetailUI.Location {
        switch self {
        case .unknown: CharacterDetailUI.Location.unknown
        case .named(let id, let name): CharacterDetailUI.Location.named(id: id, name: name)
        }
    }
}

extension CharacterDetail.Gender {
    func mapToUIModel() -> CharacterDetailUI.Gender {
        switch self {
        case .unknown: CharacterDetailUI.Gender.unknown
        case .female: CharacterDetailUI.Gender.female
        case .male: CharacterDetailUI.Gender.male
        case .genderless: CharacterDetailUI.Gender.genderless
        }
    }
}

extension CharacterDetail.Status {
    func mapToUIModel() -> CharacterDetailUI.Status {
        switch self {
        case .unknown: CharacterDetailUI.Status.unknown
        case .alive: CharacterDetailUI.Status.alive
        case .dead: CharacterDetailUI.Status.dead
        }
    }
}

extension CharacterDetail.CharacterAvatar {
    func mapToUiModel() -> CharacterDetailUI.CharacterAvatar {
        if case .cached(let imageData) = self, let uiImage = UIImage(data: imageData) {
            CharacterDetailUI.CharacterAvatar.cached(uiImage: uiImage)
        } else {
            CharacterDetailUI.CharacterAvatar.failed(defaultAvatar: .defaultAvatar)
        }
    }
}
