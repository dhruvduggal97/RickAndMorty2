//
//  DataDetailViewController.swift
//  RickAndMorty2
//
//  Created by Dhruv Duggal on 1/8/25.
//

import UIKit

class DataDetailViewController: UIViewController {
    
    private let imageServices : ImageServicing
    private let viewModel : DataDetailViewModel
    
    init(imageServices: ImageServicing, viewModel: DataDetailViewModel) {
        self.imageServices = imageServices
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let statusLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    private let charImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    private func constraints() {
        view.addSubview(nameLabel)
        view.addSubview(charImage)
        view.addSubview(locationLabel)
        view.addSubview(statusLabel)
        
        let vertStackView = UIStackView(arrangedSubviews: [charImage, nameLabel, statusLabel, locationLabel])
        vertStackView.axis = .vertical
        vertStackView.spacing = 15
        vertStackView.alignment = .center
        vertStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vertStackView)
        
        NSLayoutConstraint.activate([
        
            vertStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            vertStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            vertStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            charImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            charImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
        ])
        
    }
    
    private func config() {
        nameLabel.text = "Name: \(viewModel.getCharacterName())"
        locationLabel.text = "Location: \(viewModel.getCharacterLocation())"
        statusLabel.text = "Status: \(viewModel.getCharacterStatus())"
        charImage.loadImage(urlString: viewModel.getCharacterImageString(), imageServices: imageServices)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        config()
        constraints()

    }


}
