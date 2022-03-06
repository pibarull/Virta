//
//  StationsViewCell.swift
//  Virta
//
//  Created by Ilia Ershov on 05.03.2022.
//

import Foundation
import UIKit

final class StationsViewCell: UITableViewCell {

    private let containerView = UIView()
    private let containerStackView = UIStackView()

    private let headerContainerView = UIView()
    private let headerStackView = UIStackView()
    private let nameStackView = UIStackView()

    private let nameLabel = UILabel()
    private let cityLabel = UILabel()
    private let distanceLabel = UILabel()
    private let distanceImage = UIImageView()
    private var connectorView: ConnectorsStackView?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
        setUpLayout()
    }

    init(withBuilder builder: StationsViewCellBuilder) {
        super.init(style: .default, reuseIdentifier: nil)

        builder.name.apply {
            setName(name: $0)
        }
        builder.city.apply {
            setCity(city: $0)
        }
        builder.distance.apply {
            setDistance(distance: $0)
        }
        builder.evses.apply {
            setEvses(evses: $0)
        }

        setUpCell()
        setUpHeaderContainerView()
        setUpContainerStackView()
        setUpHeaderStackView()
        setUpDistanceLabel()
        setUpDistanceImage()
        setUpLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setName(name: String) {
        nameLabel.text = name
    }

    private func setCity(city: String) {
        cityLabel.text = city
    }

    private func setDistance(distance: String) {
        distanceLabel.text = distance
    }

    private func setEvses(evses: [Evse]) {
        connectorView = ConnectorsStackView(evses: evses)
    }

    private func setUpCell() {
        backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.addSubview(containerStackView)
        setUpName()
        setUpCity()
    }

    private func setUpName() {
        nameLabel.font = .boldSystemFont(ofSize: 12)
        nameLabel.textColor = .black
        nameLabel.adjustsFontForContentSizeCategory = true
        nameLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }

    private func setUpCity() {
        cityLabel.font = .systemFont(ofSize: 12)
        cityLabel.textColor = .black
        cityLabel.adjustsFontForContentSizeCategory = true
        cityLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }

    private func setUpContainerStackView() {
        containerStackView.addArrangedSubview(headerStackView)
        containerStackView.addArrangedSubview(connectorView!)

        containerStackView.axis = .vertical
        containerStackView.spacing = 6
    }

    private func setUpHeaderStackView() {
        headerStackView.addArrangedSubview(headerContainerView)
        headerStackView.addArrangedSubview(cityLabel)

        headerStackView.axis = .vertical
    }

    private func setUpHeaderContainerView() {
        headerContainerView.addSubview(nameLabel)
        headerContainerView.addSubview(distanceLabel)
        headerContainerView.addSubview(distanceImage)
    }

    private func setUpDistanceLabel() {
        distanceLabel.font = .systemFont(ofSize: 12)
        distanceLabel.textColor = .lightGray
        distanceLabel.adjustsFontForContentSizeCategory = true
        distanceLabel.setContentHuggingPriority(.defaultLow, for: .vertical)
    }

    private func setUpDistanceImage() {
        distanceImage.image = UIImage(named: "distance")
    }
}

extension StationsViewCell {

    func setUpLayout() {
        containerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-8)
        }

        containerStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        nameLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalTo(distanceLabel.snp.left).offset(-8)
            make.height.equalTo(24)
        }

        distanceLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerY.equalTo(distanceImage.snp.centerY)
            make.right.equalTo(distanceImage.snp.left).offset(-10)
        }

        distanceImage.snp.makeConstraints { make in
            make.size.equalTo(24)
            make.right.top.equalToSuperview()
        }
    }
}

final class StationsViewCellBuilder: ConcreteBuilder {

    var name: String?
    var city: String?
    var distance: String?
    var evses: [Evse]?

    func build() ->  StationsViewCell {
        return  StationsViewCell(withBuilder: self)
    }
}
