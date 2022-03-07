//
//  ServiceAssembly.swift
//  Virta
//
//  Created by Ilia Ershov on 06.03.2022.
//

import Swinject

final class ServiceAssembly: Assembly {

    func assemble(container: Container) {
        registerVirtaAPIClientProvider(in: container)
        registerLocationProvider(in: container)
    }

    private func registerVirtaAPIClientProvider(in container: Container) {
        container.register(VirtaAPIClient.self) { _ in
            return VirtaAPIClientService()
        }
        .inObjectScope(.container)
    }

    private func registerLocationProvider(in container: Container) {
        container.register(LocationProvider.self) { _ in
            return LocationService()
        }
        .inObjectScope(.container)
    }
}
