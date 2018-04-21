//
//  AdditionalMethods.swift
//  Yoga Manager
//
//  Created by Fayez Altamimi on 11/04/2018.
//  Copyright © 2018 Fayez Altamimi. All rights reserved.
//

import Foundation


let defaults = UserDefaults.standard

func saveLang(isArabic: Bool)
{
    if (isArabic)
    {
        defaults.set(true, forKey: "isArabic")
        
    }
    else{
        defaults.set(false, forKey: "isArabic")
        
    }
}

func isArabic()-> Bool {
    
    let isArabic = defaults.bool(forKey: "isArabic")
    
    return isArabic
}


func getDayComponent (dayName: String) ->Int
{
    switch  dayName{
        
    case "Sunday":
        return 0;
        
    case "Monday":
        return 1;
        
    case "Tuesday":
        return 2;
        
    case "Wednesday":
        return 3;
        
    case "Thursday":
        return 4;
        
    case "Friday":
        return 5;
        
    case "Saturday":
        return 6;
        
        
    default:
        return 0;
    }
}

func getDayName (componentInt: Int) -> String{
    
    switch  componentInt{
        
    case 0:
        return "Sunday";
        
    case 1:
        return"Monday";
        
    case 2:
        return "Tuesday";
        
    case 3:
        return "Wednesday";
        
    case 4:
        return "Thursday";
        
    case 5:
        return "Friday";
        
    case 6:
        return "Saturday";
        
        
    default:
        return "Sunday";
    }
}

func stringFromTime(date : Date) -> String {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat =  "HH:mm"
    
    let newDateString = dateFormatter.string(from: date)
    
    return newDateString
    
}

func timeFromString(dateString : String) -> Date {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat =  "HH:mm"
    
    let date = dateFormatter.date(from: dateString)
    
    return date!
    
}

func stringFromDate(date : Date) -> String {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat =  "dd/MM/yyyy"
    
    let newDateString = dateFormatter.string(from: date)
    
    return newDateString
    
}

func DateFromString(dateString : String) -> Date {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat =  "dd/MM/yyyy"
    
    let date = dateFormatter.date(from: dateString)
    
    return date!
    
}

func getDayDate(date: Date) -> String
{
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    
    let result = formatter.string(from: date)
    
    return result
}

func getCustomizedMagneta() -> UIColor
{
    
    //        var red = self.view.backgroundColor?.cgColor.components![0]
    //
    //        var green = self.view.backgroundColor?.cgColor.components![1]
    //
    //        var blue = self.view.backgroundColor?.cgColor.components![2]
    //        var alpha = self.view.backgroundColor?.cgColor.components![3]

    
    let color = UIColor(red:0.99881380796432495, green:0.86392885446548462, blue:0.97910517454147339, alpha:0.97910517454147339)
    
    return color
}


//func getDaysofWeekDay (weekday : Int){
//
//    var dateComponents = DateComponents()
//    dateComponents.weekday = 1
//
//    let calendar = NSCalendar.current
//
//    Calendar.current.ne
//    let date = calendar.date(from: dateComponents)!
//
//    let range = calendar.range(of: .weekday, in: .month, for: Date())
//
//    for day in range{
//
//        let test = day
//        print "\(day)"
//    }
//]   // return range
//    // New code starts here:
//
//    var numberOfSundays = 0
//
//    let dateFormatter = DateFormatter()
//
//    }

extension Date {
    
    static func today() -> Date {
        return Date()
    }
    
    func next(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.Next,
                   weekday,
                   considerToday: considerToday)
    }
    
    func previous(_ weekday: Weekday, considerToday: Bool = false) -> Date {
        return get(.Previous,
                   weekday,
                   considerToday: considerToday)
    }
    
    func get(_ direction: SearchDirection,
             _ weekDay: Weekday,
             considerToday consider: Bool = false) -> Date {
        
        let dayName = weekDay.rawValue
        
        let weekdaysName = getWeekDaysInEnglish().map { $0.lowercased() }
        
        assert(weekdaysName.contains(dayName), "weekday symbol should be in form \(weekdaysName)")
        
        let searchWeekdayIndex = weekdaysName.index(of: dayName)! + 1
        
        let calendar = Calendar(identifier: .gregorian)
        
        if consider && calendar.component(.weekday, from: self) == searchWeekdayIndex {
            return self
        }
        
        var nextDateComponent = DateComponents()
        nextDateComponent.weekday = searchWeekdayIndex
        
        
        let date = calendar.nextDate(after: self,
                                     matching: nextDateComponent,
                                     matchingPolicy: .nextTime,
                                     direction: direction.calendarSearchDirection)
        
        return date!
    }
    
}

// MARK: Helper methods
extension Date {
    func getWeekDaysInEnglish() -> [String] {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = Locale(identifier: "en_US_POSIX")
        return calendar.weekdaySymbols
    }
    
    enum Weekday: String {
        case monday, tuesday, wednesday, thursday, friday, saturday, sunday
    }
    
    enum SearchDirection {
        case Next
        case Previous
        
        var calendarSearchDirection: Calendar.SearchDirection {
            switch self {
            case .Next:
                return .forward
            case .Previous:
                return .backward
            }
        }
    }
    
    func dayOfTheWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}

extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
}

func getArrayOfWeekDays(weekDay: Date.Weekday, numberOfForwardDays: Int, numberOfBackwardDays: Int) -> [String]
{
 
    var array = [String]()
    
    if(numberOfBackwardDays > 0) {
        
        for i in 1 ... numberOfBackwardDays {
            
            var backWardDate  = Date()
            
            if(numberOfBackwardDays > 0)
            {
                
                let j = numberOfBackwardDays - i + 1
                
                backWardDate = Date.today()
                
                for _ in 1 ... j {
                    
                    backWardDate = backWardDate.previous(weekDay)
                    
                }
                
                array.append(stringFromDate(date: backWardDate))
            }
        }
    }

    
    if(Date().dayOfTheWeek()?.lowercased() == weekDay.rawValue)
    {
        array.append(stringFromDate(date: Date()))
    }
    
   
    var forwardDate: Date
    
    forwardDate = Date.today().next(weekDay)

    if(numberOfForwardDays >= 1)
    {
        
        array.append(stringFromDate(date: forwardDate))
    }

    if(numberOfForwardDays > 2)
    {
        
        for _ in 2 ... numberOfForwardDays {
            
            forwardDate = forwardDate.next(weekDay)
            
            array.append(stringFromDate(date: forwardDate))
        }
    }

    
    return array

}

func getDatesArrayforGroupSessions(group: Group) -> [String]
{
    let sessions = SessionViewModel().getGroupSessions(studentsGroup: group)
    
    var ArraysofDaysArrays = [[Date]]()
    
    for session in sessions {
        
        var tempStringArrays = [String]()
                
        tempStringArrays = getArrayOfWeekDays(weekDay:  Date.Weekday(rawValue: (session.week_day!.lowercased()))!, numberOfForwardDays: 6, numberOfBackwardDays: 5)
        
        var tempDateArrays = [Date]()
        
        for string in tempStringArrays {
            
            tempDateArrays.append(DateFromString(dateString: string))
        }
        
       ArraysofDaysArrays.append(tempDateArrays)
    }
    
    var tempFinalArray = [Date]()
    
    for array in ArraysofDaysArrays {
        
        for date in array {
            
            tempFinalArray.append(date)
        }
        
    }
    
    var finalArray = [Date]()
    
    while tempFinalArray.count > 0{
        
        finalArray.append(tempFinalArray.min()!)
        
        tempFinalArray.remove(at: tempFinalArray.index(of: tempFinalArray.min()!)!)
    }

    var stringArray = [String]()
    
    for date in finalArray{
        
        stringArray.append(stringFromDate(date: date))
    }
    
    return stringArray
}

func countDaysDifference(startDate: Date, endDate: Date) -> Int{
    
    
    let components = Calendar.current.dateComponents([.day], from: startDate, to: endDate)
    let numberOfDays = components.day ?? 0
    
    return numberOfDays
    
//    for i in 1...numberOfDays {
//        let nextDate = Calendar.current.date(byAdding: .day, value: i, to: startDate)
//    }
}

func getNext30Days() -> [String]{
    
let calendar = Calendar(identifier: .gregorian)
    
    var dateComponent = DateComponents()
    
   var arrayofDatesString = [String]()
    for i in 1...30
    {
        
        dateComponent.day = i
        let newDate = stringFromDate(date: calendar.date(byAdding: dateComponent, to: Date())!)
       
        arrayofDatesString.append(newDate)
    }
    
    return arrayofDatesString
}

