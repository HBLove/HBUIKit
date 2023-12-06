//
//  Date+Extension.swift
//  HB
//
//  Created by 黄波 on 2023/12/4.
//

import Foundation
public extension Date{
    /// - Parameter format: Date format (default is "dd/MM/yyyy").
    /// - Returns: date string.
    func string(withFormat format: String = "dd/MM/yyyy HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

    static func dateFromString(_ string: String, withFormat format: String = "yyyy-MM-dd") -> Date{
        let fmt = DateFormatter()
        //设定时间格式,这里可以设置成自己需要的格式
        fmt.dateFormat = format
        return fmt.date(from: string) ?? Date()
    }
    // 年月获得天数
    static func days(_ year: Int, month: Int) -> Int{
        let calendar = Calendar.current
        let curYMD = Date().ymd
        if curYMD.year == year, month == curYMD.month{
            return curYMD.day
        }
        let component = DateComponents(year: year, month: month)
        
        guard let date = calendar.date(from: component),
              let range = calendar.range(of: .day, in: .month, for: date) else{return 0}
        return range.count
    }
    ///年龄计算
    static func age(_ year: Int, month: Int, day: Int) -> (age: Int, des: String){
        let ymd = Date().ymd
        var age = ymd.year - year
        if ymd.month - month < 0 {
            age -= 1
        }else if ymd.month == month, ymd.day - day < 0{
            age -= 1
        }
        if age < 0 {
            return (0,"0岁")
        }else if age == 0{
            var mo = ymd.month - month
            if ymd.day - day < 0 {
                mo -= 1
            }
            if mo <= 0 {
                return (0,"\(ymd.day - day)天")
            }
            return (0,"\(ymd.month - month)月")
        }
        return (age, "\(age)岁")
    }
    //星座计算
    static func constellation(month: Int, day: Int) -> String{
        let constellations = ["水瓶座", "双鱼座", "白羊座", "金牛座", "双子座", "巨蟹座", "狮子座", "处女座", "天秤座", "天蝎座", "射手座", "摩羯座"]
        let conIndexs = [20, 19, 21, 20, 21, 22, 23, 23, 23, 24, 23, 22]
        if (conIndexs[month-1] <= day) {
            return constellations[month-1]
        } else{
            let index = (month - 2 + 12) % 12
             return constellations[index]
        }
    }
    //时间显示 是否强制显示
    func distanceTime(isShow: Bool = false) -> String{
        let curDate = Date()
        guard self.isInToday == false else{
            let time  = Int(curDate.secondsSince(self))
            if  time < 60*5{
                return isShow ? "刚刚": ""
            }else if time < 60*60{
                return  "\(time/60)分钟"
            }
            return "\(time/3600)小时"
        }
        let formatter = DateFormatter()
        if self.isInYesterday{
            return "昨天"
        }else if self.isInCurrentYear == false{
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
        }else if self.isInCurrentWeek{
            return self.weekday
        }else if self.isInCurrentMonth{
            formatter.dateFormat = "dd HH:mm"
        }else{
            formatter.dateFormat = "MM-dd HH:mm"
        }
        return formatter.string(from: self)
    }
    
    ///时间的秒
    func secondsSince(_ date: Date) -> Double {
        return timeIntervalSince(date)
    }
}

// MARK: - 年月日星期
extension Date{
    /// 时间的年月日
    var ymd:(year: Int, month: Int, day: Int){
        let components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        return (components.year ?? 0, components.month ?? 0, components.day ?? 0)
    }
    ///星期几
    var weekday: String {
        let week = Calendar.current.component(.weekday, from: self)
        switch week {
        case 0:
            return "星期天"
        case 1:
            return "星期一"
        case 2:
            return "星期二"
        case 3:
            return "星期三"
        case 4:
            return "星期四"
        case 5:
            return "星期五"
        case 6:
            return "星期六"
        default:
            return "今天"
        }
    }
    ///时分秒
    var hms:(hour: Int, minute: Int, second: Int){
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: self)
        return (components.hour ?? 0, components.minute ?? 0, components.second ?? 0)
    }
    var nanosecond: Int{
        return  Calendar.current.component(.nanosecond, from: self)
    }
    var millisecond: Int{
        return nanosecond / 1_000_000
    }
    ///     Date(timeInterval: 100, since: Date()).isInFuture -> true
    /// 将来
    var isInFuture: Bool {
        return self > Date()
    }

    ///  Check if date is in past.
    ///
    ///     Date(timeInterval: -100, since: Date()).isInPast -> true
    /// 过去
    var isInPast: Bool {
        return self < Date()
    }
    ///  Check if date is within today.
    ///
    ///     Date().isInToday -> true
    ///
    var isInToday: Bool {
        return Calendar.current.isDateInToday(self)
    }

    ///  Check if date is within yesterday.
    ///
    ///     Date().isInYesterday -> false
    ///
    var isInYesterday: Bool {
        return Calendar.current.isDateInYesterday(self)
    }

    ///  Check if date is within tomorrow.
    ///
    ///     Date().isInTomorrow -> false
    ///
    var isInTomorrow: Bool {
        return Calendar.current.isDateInTomorrow(self)
    }

    ///  Check if date is within a weekend period.
    var isInWeekend: Bool {
        return Calendar.current.isDateInWeekend(self)
    }

    ///  Check if date is within a weekday period.
    var isWorkday: Bool {
        return !Calendar.current.isDateInWeekend(self)
    }

    ///  Check if date is within the current week.
    var isInCurrentWeek: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .weekOfYear)
    }

    ///  Check if date is within the current month.
    var isInCurrentMonth: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .month)
    }

    ///  Check if date is within the current year.
    var isInCurrentYear: Bool {
        return Calendar.current.isDate(self, equalTo: Date(), toGranularity: .year)
    }
    
}
