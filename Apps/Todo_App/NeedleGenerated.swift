

import Dependency_Realm
import Feature_Todo_Form
import Feature_Todo_List
import Foundation
import Foundation_Todo_Repository
import NeedleFoundation
import Overture
import UIKit

// MARK: - Registration

public func registerProviderFactories() {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->TodoListComponent") { component in
        return TodoListDependency7e2cba0f551ae926232bProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent") { component in
        return EmptyDependencyProvider(component: component)
    }
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: "^->RootComponent->TodoListComponent->TodoFormComponent") { component in
        return TodoFormDependency6d86c1bf658157bad8e5Provider(component: component)
    }
    
}

// MARK: - Providers

/// ^->RootComponent->TodoListComponent
private class TodoListDependency7e2cba0f551ae926232bProvider: TodoListDependency {
    var todoListRepository: TodoListRepository {
        return rootComponent.todoListRepository
    }
    var updateTodoRepository: UpdateTodoRepository {
        return rootComponent.updateTodoRepository
    }
    private let rootComponent: RootComponent
    init(component: NeedleFoundation.Scope) {
        rootComponent = component.parent as! RootComponent
    }
}
/// ^->RootComponent->TodoListComponent->TodoFormComponent
private class TodoFormDependency6d86c1bf658157bad8e5Provider: TodoFormDependency {
    var addTodoRepository: AddTodoRepository {
        return rootComponent.addTodoRepository
    }
    var onDismiss: (UIViewController) -> Void {
        return rootComponent.onDismiss
    }
    private let rootComponent: RootComponent
    init(component: NeedleFoundation.Scope) {
        rootComponent = component.parent.parent as! RootComponent
    }
}
