//
//  DataTableViewCell.swift
//  RickAndMorty2
//
//  Created by Dhruv Duggal on 1/8/25.
//


import UIKit

class DataTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let cellIdentifier = "DataTableViewCell"
    
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

    
    private let charImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    
    private func constraints() {
        addSubview(charImage)
        addSubview(nameLabel)
        addSubview(statusLabel)
        
        let vertStackView = UIStackView(arrangedSubviews: [nameLabel, statusLabel])
        vertStackView.axis = .vertical
        vertStackView.spacing = 10
        
        let horStackView = UIStackView(arrangedSubviews: [charImage, vertStackView])
        horStackView.axis = .horizontal
        horStackView.spacing = 10
        horStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(horStackView)
        
        NSLayoutConstraint.activate([
            horStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            horStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            horStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            horStackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            charImage.widthAnchor.constraint(equalToConstant: 50),
            charImage.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    public func configure(character: Character, imageServices: ImageServicing) {
        nameLabel.text = character.name
        statusLabel.text = character.status
        charImage.loadImage(urlString: character.image, imageServices: imageServices)
    }
    
    override func prepareForReuse() {
        nameLabel.text = nil
        statusLabel.text = nil
        charImage.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UIImageView {
    func loadImage(urlString: String, imageServices: ImageServicing) {
        imageServices.getImage(urlString: urlString) { result in
            switch result {
            case .success(let image):
                if let image = image {
                    DispatchQueue.main.async { [weak self] in
                        self?.image = image
                    }
                }
            case .failure(_):
                print("Failure getting image")
            }
        }
    }
}
