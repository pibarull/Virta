//
//  ConnectorsStackView.swift
//  Virta
//
//  Created by Ilia Ershov on 06.03.2022.
//

import Foundation
import UIKit

private enum Constants{

    static let connectorsLimit = 3
}

final class ConnectorsStackView: UIView {

    private var evses: [Evse] = []

    private let stackView = UIStackView()

    init(evses: [Evse]) {
        self.evses = evses
        super.init(frame: .zero)

        stackView.axis = .vertical
        stackView.spacing = 10
        addSubview(stackView)
        
        setUpView()
        setUpLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpView() {
        var connectors: [Connector] = []
        evses.forEach { connectors.append(contentsOf: $0.connectors) }
        var uniqConnectors = Array(Set(connectors))
        var dict = [Int: Int]()

        connectors.forEach { connector in
            if !dict.keys.contains(where: { $0 == connector.maxKw }) {
                dict[connector.maxKw] = 1
            } else {
                dict[connector.maxKw]! += 1
            }
        }

        uniqConnectors.sort { lhs, rhs in
            lhs.maxKw > rhs.maxKw
        }

        var uniqConnectorsViews = uniqConnectors.map({ connector -> ConnectorView in
            let connectorView = ConnectorView()
            connectorView.setUpView(amount: dict[connector.maxKw] ?? 1, power: connector.maxKw)
            return connectorView
        })

        while !uniqConnectorsViews.isEmpty {
            let xStackView = UIStackView()
            xStackView.axis = .horizontal
            xStackView.spacing = 30
            xStackView.distribution = .fill

            let spacer = UIView()
            spacer.isUserInteractionEnabled = false
            spacer.setContentHuggingPriority(.fittingSizeLevel, for: .horizontal)
            spacer.setContentCompressionResistancePriority(.fittingSizeLevel, for: .horizontal)

            defer { xStackView.addArrangedSubview(spacer) }

            stackView.addArrangedSubview(xStackView)

            for _ in 0 ... Constants.connectorsLimit-1 {
                guard let connectorView = uniqConnectorsViews.popLast() else { return }
                xStackView.addArrangedSubview(connectorView)
            }
        }
    }

    private func setUpLayout() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setUpView(evses: [Evse]) {
        self.evses = evses
    }
}
