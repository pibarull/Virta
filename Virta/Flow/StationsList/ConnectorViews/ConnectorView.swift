//
//  ConnectorView.swift
//  Virta
//
//  Created by Ilia Ershov on 05.03.2022.
//

import Foundation
import UIKit

final class ConnectorView: UIView {

    private let connectorImageView = UIImageView()
    private let connectorNumLabel = UILabel()
    private let powerValueLabel = UILabel()
    private let powerKwLabel = UILabel()

    init() {
        super.init(frame: .zero)

        setUpView()
        setUpConnectorImageView()
        setUpConnectorNumLabel()
        setUpPowerValueLabel()
        setUpPowerKwLabel()

        setUpLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    private func setUpView() {
        backgroundColor = .clear
        addSubview(connectorImageView)
        addSubview(connectorNumLabel)
        addSubview(powerValueLabel)
        addSubview(powerKwLabel)
    }

    private func setUpConnectorImageView() {
        connectorImageView.image = UIImage(named: "connector")
    }

    private func setUpConnectorNumLabel() {
        connectorNumLabel.font = .systemFont(ofSize: 10)
        connectorNumLabel.textColor = .black
        connectorNumLabel.textAlignment = .center
    }

    private func setUpPowerValueLabel() {
        powerValueLabel.font = .boldSystemFont(ofSize: 22)
        powerValueLabel.textColor = .black
    }

    private func setUpPowerKwLabel() {
        powerKwLabel.text = "kW"
        powerKwLabel.font = .systemFont(ofSize: 12)
        powerKwLabel.textColor = .black
        powerKwLabel.textAlignment = .center
    }

    private func setUpLayout(){

        connectorImageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview()
            make.right.equalTo(powerValueLabel.snp.left).offset(-10)
            make.right.equalTo(powerKwLabel.snp.left).offset(-10)
            make.bottom.equalTo(connectorNumLabel.snp.top)
            make.centerY.equalToSuperview().priority(.medium)
        }

        connectorNumLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalTo(connectorImageView.snp.bottom)
            make.centerX.equalTo(connectorImageView.snp.centerX)
        }

        powerValueLabel.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
        }

        powerKwLabel.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview()
            make.top.equalTo(powerValueLabel.snp.bottom)
        }

        connectorImageView.snp.makeConstraints { make in
            make.size.equalTo(30)
        }
    }

    func setUpView(amount: Int, power: Int) {
        connectorNumLabel.text = "x\(amount)"
        powerValueLabel.text = "\(power)"
        let connectorNumLabelIsHidden = (amount == 1)
        if connectorNumLabelIsHidden {
            connectorNumLabel.removeFromSuperview()
            connectorImageView.snp.removeConstraints()
            connectorImageView.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.right.equalTo(powerValueLabel.snp.left).offset(-10)
                make.right.equalTo(powerKwLabel.snp.left).offset(-10)
                make.centerY.equalToSuperview()
            }
        }
    }
}
