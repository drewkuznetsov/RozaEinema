//
//  Tour.swift
//  RozaEinema
//
//  Created by Андрей Кузнецов on 21.04.2022.
//

import Foundation

enum TourType: String {
    case musium = "Выставка"
    case smallMasterClass = "Я Кондитер"
    case bigMasterclass = "Уроки Шоколадье"
    case roof = "Крыша"
    case street = "Прежде и Теперь"
}

enum Speaker: String {
    case andrey = "Андрей"
    case toma = "Тамара"
    case sonia = "Софья"
    case nata = "Наталья"
}

typealias TourTime = (hour: Int, minute: Int)

class Tour: Identifiable {
    
    var id = UUID()
    var type: TourType
    var speaker: Speaker
    var time: TourTime
    var visitors = [Visitor]()
    
    var optionalTour: Tour?
    
    
    init(type: TourType, speaker: Speaker, time: TourTime) {
        self.type = type
        self.speaker = speaker
        self.time = time
    }
    
    init(type: TourType, speaker: Speaker, date: Date) {
        
        self.type = type
        self.speaker = speaker
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        self.time.hour = components.hour ?? 0
        self.time.minute = components.minute ?? 0
    }
    
    var getTime: String {
        var minutes: String = ""
        if time.minute < 10 {
            minutes = "0\(time.minute)"
        } else {
            minutes = "\(time.minute)"
        }
        return "\(time.hour):\(minutes)"
    }
    
    var numberOfVisiters: Int {
        var rezult = 0
        for visitor in visitors {
            rezult += visitor.amount
        }
        return rezult
    }
    
    func addVisitor(visitor: Visitor) {
        
        var newVisitor = Visitor()
        
        newVisitor.name = visitor.name
        newVisitor.phone = visitor.phone
        newVisitor.amount = visitor.amount
        newVisitor.prePaid = visitor.prePaid
        newVisitor.notes = visitor.notes
        
        self.visitors.append(newVisitor)
        
        if self.optionalTour != nil {
            self.optionalTour?.addOptionalVisitor(visitor: newVisitor, atIndex: self.visitors.count - 1)
        }
    }
 /*
    func deletVisitor(atIndex: Int) {
        
        guard self.visitors[atIndex].editable else { return }
        
        self.visitors.remove(at: atIndex)
        
        if self.optionalExcursion != nil {
            self.optionalExcursion?.deleteOptionalVisitor(atIndex: atIndex)
        }
    }
 */
}

//MARK: - Optional Tour Extension

extension Tour {
    
    func addOptionalTour(type: TourType, speaker: Speaker) {
        
        let newTime = (self.time.hour + 1, self.time.minute)
        let newTour = Tour(type: type, speaker: speaker, time: newTime)
        newTour.visitors = self.visitors
        self.optionalTour = newTour
    }
    
    private func addOptionalVisitor(visitor: Visitor, atIndex: Int) {
        
        var newVisitor = Visitor()
        
        newVisitor.name = visitor.name
        newVisitor.amount = visitor.amount
        newVisitor.phone = visitor.phone
        newVisitor.prePaid = visitor.prePaid
        newVisitor.notes = visitor.notes
        newVisitor.isEditable = false
        
        self.visitors.insert(newVisitor, at: atIndex)
        
        if self.optionalTour != nil {
            self.optionalTour?.addOptionalVisitor(visitor: newVisitor, atIndex: self.visitors.count - 1)
        }
    }
/*
    private func deleteOptionalVisitor(atIndex: Int) {
        
        self.visitors.remove(at: atIndex)
        
        if self.optionalExcursion != nil {
            self.optionalExcursion?.deleteOptionalVisitor(atIndex: atIndex)
        }
    }
 */
}
