//
//  StationViewController.swift
//  Virta
//
//  Created by Ilia Ershov on 06.03.2022.
//

import Foundation
import UIKit

final class StationViewController: UIViewController {

    private let stationNameLabel = UILabel(frame: .init(x: 0, y: 0, width: 200, height: 50))

    private let stationViewModel = StationViewModel()
    private let stationId: Int
    private var station: Station?

    init(stationId: Int) {
        self.stationId = stationId
        super.init(nibName: nil, bundle: nil)

        stationViewModel.vc = self
        station = stationViewModel.getStation()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(stationNameLabel)
        stationNameLabel.center = view.center
        stationNameLabel.text = station?.name
        stationNameLabel.textColor = .black
        
    }
}
