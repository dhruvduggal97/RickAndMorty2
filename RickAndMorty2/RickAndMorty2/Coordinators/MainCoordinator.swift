//
//  MainAppCoordinator.swift
//  RickAndMorty2
//
//  Created by Dhruv Duggal on 1/8/25.
//

import Foundation
import UIKit

protocol MainCoordinating {
    var navigationController : UINavigationController {get set}
    func start()
    func showDetails(character: Character)
}

class MainCoordinator : MainCoordinating {
    
    var navigationController : UINavigationController
    private var cacheManager = DataCacheManager()
    private var dataManager : APIDataManaging
    private var characterServices : CharacterServicing
    private var imageServices : ImageServicing
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.dataManager = APIDataManager(cacheManager: cacheManager)
        self.characterServices = CharacterServices(dataManager: dataManager)
        self.imageServices = ImageServices(dataManager: dataManager)
    }
    
    func start() {
        let dataVM = DataTableViewModel(characterServices: characterServices)
        dataVM.coordinator = self
        let dataVC = DataTableViewController(imageServices: imageServices, viewModel: dataVM)
        navigationController.pushViewController(dataVC, animated: true)
        
    }
    
    func showDetails(character: Character) {
        let detailVM = DataDetailViewModel(character: character)
        let detailVC = DataDetailViewController(imageServices: imageServices, viewModel: detailVM)
        navigationController.pushViewController(detailVC, animated: true)
    }
}
