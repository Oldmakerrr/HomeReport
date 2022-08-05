//
//  ParseJSON.swift
//  HomeReport
//
//  Created by Apple on 05.08.2022.
//

import Foundation
import UIKit
import CoreData

class ParseJson {
    
    let coreData: CoreDataStack
    
    init(coreData: CoreDataStack) {
        self.coreData = coreData
    }
    
    func uploadSampleData() {
        guard let url = Bundle.main.url(forResource: "homes", withExtension: "json") else { return }
        let moc = coreData.persistentContainer.viewContext
        do {
            let data = try Data(contentsOf: url)
            do {
                guard let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary,
                      let jsonArray = jsonResult.value(forKey: "home") as? NSArray else { return }
                for json in jsonArray {
                    parseHome(json: json, moc: moc)
                }
            } catch  {
                fatalError("Cannot upload sample data")
            }
            coreData.saveContext()
        } catch let error as NSError {
            print("Failed create data from url with error: \(error.localizedDescription)")
        }
        
    }
    
    private func parseHome(json: NSArray.Element, moc: NSManagedObjectContext) {
        guard let homeData = json as? [String: AnyObject],
              let bath = homeData["bath"],
              let bed = homeData["bed"],
              let city = homeData["city"] as? String,
              let price = homeData["price"] as? Double,
              let sqft = homeData["sqft"],
              let homeCategory = homeData["category"] as? NSDictionary,
              let homeStatus = homeData["status"] as? NSDictionary,
              let isForSale = homeStatus["isForSale"] as? Bool else { return }
            
        var image = UIImage()
        if let imageName = homeData["image"] as? String, let currentImage = UIImage(named: imageName) {
            image = currentImage
        }
        let homeType = homeCategory["homeType"] as? String
        
        let home = homeType?.caseInsensitiveCompare("condo") == .orderedSame
        ? Condo(context: moc)
        : SingleFamily(context: moc)
        
        home.bath = bath.int16Value
        home.bed = bed.int16Value
        home.price = price
        home.city = city
        home.sqft = sqft.int16Value
        home.image = image.jpegData(compressionQuality: 1.0)
        home.isForSale = isForSale
        
        if let unitsPerBuilding = homeData["unitsPerBuilding"], home is Condo {
            (home as! Condo).unitsPerBuilding = unitsPerBuilding.int16Value
        }
        
        if let lotSize = homeData["lotSize"], home is SingleFamily {
            (home as! SingleFamily).lotSize = lotSize.int16Value
        }
        parseSaleHistory(homeData: homeData, home: home, moc: moc)
    
    }
    
    private func parseSaleHistory(homeData: [String: Any], home: Home, moc: NSManagedObjectContext) {
        
        guard let saleHistory = homeData["saleHistory"] as? NSArray,
              let saleHistoryData = home.saleHistory?.mutableCopy() as? NSMutableSet else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for saleDetail in saleHistory {
            guard let saleData = saleDetail as? [String: AnyObject],
                  let soldPrice = saleData["soldPrice"] as? Double else { return }
            let saleHistory = SaleHistory(context: moc)
            saleHistory.soldPrice = soldPrice
            
            if let soldDateStr = saleData["soldDate"] as? String,
               let soldDate = dateFormatter.date(from: soldDateStr) {
                saleHistory.soldDate = soldDate
            }
            saleHistoryData.add(saleHistory)
        }
        
        home.addToSaleHistory(saleHistoryData.copy() as! NSSet)
    }
    
}
