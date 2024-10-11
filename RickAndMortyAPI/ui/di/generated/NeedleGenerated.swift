

import Foundation
import NeedleFoundation

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class UiComponentDependency8fcdf1face1bcc5f7d59Provider: UiComponentDependency {
    var rickAndMortyInteractor: RickAndMortyInteractor {
        return domainComponent.rickAndMortyInteractor
    }
    private let domainComponent: DomainComponent
    init(domainComponent: DomainComponent) {
        self.domainComponent = domainComponent
    }
}
/// ^->RootComponent->DataComponent->DomainComponent->UiComponent
private func factory099dcd61a65243be5d2e2da49790c7fa08e884b6(_ component: NeedleFoundation.Scope) -> AnyObject {
    return UiComponentDependency8fcdf1face1bcc5f7d59Provider(domainComponent: parent1(component) as! DomainComponent)
}
private class DomainComponentDependency1eca1dc8f13b68330988Provider: DomainComponentDependency {
    var rickAndMortyRepository: RickAndMortyRepository {
        return dataComponent.rickAndMortyRepository
    }
    private let dataComponent: DataComponent
    init(dataComponent: DataComponent) {
        self.dataComponent = dataComponent
    }
}
/// ^->RootComponent->DataComponent->DomainComponent
private func factorye6dbc1fed31c0dc1b25a10c2c8cacafa02ba9dbf(_ component: NeedleFoundation.Scope) -> AnyObject {
    return DomainComponentDependency1eca1dc8f13b68330988Provider(dataComponent: parent1(component) as! DataComponent)
}

#else
extension RootComponent: NeedleFoundation.Registration {
    public func registerItems() {


    }
}
extension DataComponent: NeedleFoundation.Registration {
    public func registerItems() {

        localTable["rickAndMortyRepository-RickAndMortyRepository"] = { [unowned self] in self.rickAndMortyRepository as Any }
    }
}
extension UiComponent: NeedleFoundation.Registration {
    public func registerItems() {
        keyPathToName[\UiComponentDependency.rickAndMortyInteractor] = "rickAndMortyInteractor-RickAndMortyInteractor"
    }
}
extension DomainComponent: NeedleFoundation.Registration {
    public func registerItems() {
        keyPathToName[\DomainComponentDependency.rickAndMortyRepository] = "rickAndMortyRepository-RickAndMortyRepository"
        localTable["rickAndMortyInteractor-RickAndMortyInteractor"] = { [unowned self] in self.rickAndMortyInteractor as Any }
    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->RootComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->RootComponent->DataComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->RootComponent->DataComponent->DomainComponent->UiComponent", factory099dcd61a65243be5d2e2da49790c7fa08e884b6)
    registerProviderFactory("^->RootComponent->DataComponent->DomainComponent", factorye6dbc1fed31c0dc1b25a10c2c8cacafa02ba9dbf)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
