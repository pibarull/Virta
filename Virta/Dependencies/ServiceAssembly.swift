//
//  ServiceAssembly.swift
//  Virta
//
//  Created by Ilia Ershov on 06.03.2022.
//

import Swinject

final class ServiceAssembly: Assembly {

    func assemble(container: Container) {
        registerVirtaAPIClientProvider(container: container)
    }

    private func registerVirtaAPIClientProvider(container: Container) {
        container.register(VirtaAPIClient.self) { _ in
            return VirtaAPIClientService()
        }
        .inObjectScope(.container)
    }
}
