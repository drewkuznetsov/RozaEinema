//
//  WorkDay.swift
//  RozaEinema
//
//  Created by Андрей Кузнецов on 21.04.2022.
//

import Foundation

typealias TourDate = (year: Int, month: Int, day: Int)

class WorkDay {
    
    let date: TourDate
    let tours = [Tour]()
    
    init(date:Date) {
        let components = Calendar.current.dateComponents([.year, .month,.day], from: date)
        self.date.year = components.year ?? 0
        self.date.month = components.month ?? 0
        self.date.day = components.day ?? 0
    }
}
