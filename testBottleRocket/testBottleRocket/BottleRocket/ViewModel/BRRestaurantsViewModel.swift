//
//  BRRestaurantsViewModel.swift
//  testBottleRocket
//
//  Created by roreyesl on 07/09/21.
//

import Foundation


public class BRRestaurantsViewModel : Decodable{
    
    // MARK: - Properties
    
    public typealias CompletionBlock = (NSError) -> Void
    private var serviceManager : Webservice?
    private let URL_GET_RESTAURANT_DATA = "/br-codingexams/restaurants.json"
    public init(_ serviceManager : Webservice = Webservice()){
        self.serviceManager = serviceManager
    }
    public var detailRestaurants: [detailRestaurant]?
    
    // MARK: - LifeCycle
    required public init(from decoder: Decoder) throws {}
    
    // MARK: - Functions
    
    public func loadInfoRestaurant(withCompletionHandler handler: @escaping CompletionBlock){
        
        var resource = Resource<ResponseRestaurant>(URL_GET_RESTAURANT_DATA, .baseCore)
        resource.httpMethod = .get
        resource.showProgress = true
        serviceManager?.load(resource: resource){ result in
            switch result{
            case .success(let detailRestaurant, let error):
                self.detailRestaurants = detailRestaurant.result
                handler(error ?? NSError(domain: "BottleRocket", code: error?.code ?? 500, userInfo: error?.userInfo))
            case .failure(let error):
                handler(error ?? NSError(domain: "BottleRocket", code: error?.code ?? 500, userInfo: error?.userInfo))
            }
        }
    }
    
    func getDataRestaurantAtIndex(withRow iRow:Int) -> detailRestaurant? {
        return detailRestaurants?[iRow]
    }
    
    func getNumberOfRowsInSection() -> Int {
        return detailRestaurants?.count ?? 0
    }
}
