//
//  DayDataSource.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 08.08.2023.
//

import UIKit


struct Group{
    static let morning = 0
    static let disposable = 1
    static let freeTime = 2
    static let work = 3
}

struct UpdatedProgressModel{
    let totalCount: Int
    let currentCount: Int
    let indexPath: [IndexPath]
}

protocol RoutineModel{
    func isHeader() -> Bool
    func getGroup() -> Int
    func getTitle() -> String
    var reuseIdentifier: String { get }
}

protocol RoutineCell: UITableViewCell {
    func update(with model: RoutineModel)
}

final class DayDataSource : NSObject, UITableViewDataSource, UITableViewDelegate{
    
    
    
    private var totalCount = 0
    private var currentCount = 0
    private var data: [RoutineModel] = []
    
    
    
    func setData(data: [RoutineModel]){
        self.data = data
        self.totalCount = self.data.filter({$0 is TaskCellModel}).count
        self.currentCount = totalCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = data[indexPath.row]
        let id = model.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath)  as! RoutineCell
        cell.update(with: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.none
    }
    
    
    
    
    func removeModelByName(_ itemName: String) -> UpdatedProgressModel?{
        guard let index: Int = self.data.firstIndex(where: {$0.getTitle() == itemName}) else {
            return nil
        }
        
        let groupType = self.data[index].getGroup()
        self.data.remove(at: index)
        self.currentCount -= 1
        
        var indexPath: [IndexPath] = [IndexPath(row: index, section: 0)]
        indexPath.append(contentsOf: removeHeaderIfNeeded(groupType: groupType))
        
        return UpdatedProgressModel(
            totalCount: totalCount,
            currentCount: currentCount,
            indexPath: indexPath
        )
    }
    
    
    
    private func removeHeaderIfNeeded(groupType: Int) -> [IndexPath]{
        let leftIngroupItems = self.data.filter { !$0.isHeader() && $0.getGroup() == groupType }.count
        
        if(leftIngroupItems == 0){
            let index = self.data.firstIndex { $0.isHeader() && $0.getGroup() == groupType }
            self.data.remove(at: index!)
            return [IndexPath(row: index!, section: 0)]
        }
        
        return []
    }
    
    
}
