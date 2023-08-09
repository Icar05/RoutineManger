//
//  DayPresenter.swift
//  RoutineManager
//
//  Created by Галяткин Александр on 08.08.2023.
//

import UIKit


public struct DayContent{
    let models: [RoutineModel]
    let day: String
}

public final class DayPresenter{
    
    
    
    private let dayDataProvider = DayDataProvider()
    
    unowned var view: DayViewController!
    
    public func set(view: DayViewController) {
        self.view = view
    }
    
    public func fetchData(){
        let сontent = DayContent(models: getModels(), day: getDayOfWeek())
        self.view.updateTableViewContent(content: сontent)
    }
    
    
    private func getDayOfWeek() -> String{
        return Date().dayOfWeek()!
    }
    
    private func getModels() -> [RoutineModel]{
        var models: [RoutineModel] = [RoutineModel]()
        let activitesModel = self.dayDataProvider.getActivitiesModel()
        
        
        models.append(HeaderCellModel(
            group: Group.morning,
            title: "С утра:",
            color: UIColor.appRed(),
            titleColor: .black))
        
        models.append(contentsOf: getMorningActivityModels(
            activities: activitesModel.generalActivities)
        )
        
        
        models.append(HeaderCellModel(
            group: Group.disposable,
            title: "Одноразовые:",
            color: UIColor.orange,
            titleColor: .black))
        
        models.append(contentsOf: getDisposableActivities(
            activities: activitesModel.disposableActivities)
        )
        
        models.append(getWoringActivity())
        models.append(HeaderCellModel(
            group: Group.freeTime,
            title: "Приключение дня: ",
            color: UIColor.appGreen(),
            titleColor: .black))
        
        models.append(getFreetimeActivity(
            activities: activitesModel.freeTimeActivities)
        )
        
        return models
    }
    
    
    private func getFreetimeActivity(activities: [String]) -> RoutineModel {
        TaskCellModel(
            group: Group.freeTime,
            title: getRandomFreetimeItem(activities: activities),
            onDone: { [weak self ] value in
                self?.view.removeItem(itemName: value)
            })
    }
    
    private func getWoringActivity() -> RoutineModel{
        return ActionCellModel(
            group: Group.work,
            title: "Работа / тренировка",
            backgrooundColor: .darkGray,
            textColor: .black) { [weak self ]  in
                self?.view?.navigateToTimer()
        }
    }
    
    private func getDisposableActivities(activities: [String]) -> [RoutineModel]{
        return activities.map{
            TaskCellModel(
                group: Group.disposable,
                title: $0) { [weak self ] value in
                    self?.view.removeItem(itemName: value)
            }
        }
    }
    
    private func getMorningActivityModels(activities: [String]) -> [RoutineModel]{
        return activities.map{
            TaskCellModel(
                group: Group.morning,
                title: $0) { [weak self ] value in
                    self?.view.removeItem(itemName: value)
            }
        }
    }
    
    private func getRandomFreetimeItem(activities: [String]) -> String{
        return activities[Int.random(in: 0..<activities.count)]
    }
    
}
