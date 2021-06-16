//
//  DateSelectionHelper.swift
//  Bedcoin
//
//  Created by Sudipta Patel on 17/01/20.
//  Copyright © 2020 Sudipta Patel. All rights reserved.
//

import UIKit
import CalendarDateRangePicker

typealias DateRangeCompletionBlock = (_ startDate: Date?, _ endDate: Date?, _ isCancel:Bool) -> ()

class DateSelectionHelper: NSObject {

    static let shared = DateSelectionHelper()
    var dateRangeCompletion: DateRangeCompletionBlock?
    var dateRangePickerViewController = CalendarDateRangePickerViewController()

    /*
    func showCalendar(with minDate:Date, maxDate:Date, target: UIViewController,completion:DateRangeCompletionBlock?) {
            
        dateRangePickerViewController = CalendarDateRangePickerViewController(collectionViewLayout: UICollectionViewFlowLayout())
          //  dateRangePickerViewController.cellFont = UIFont(name: "Montserrat-Regular", size: 15.0)!
            
            
        dateRangePickerViewController.delegate = self
        dateRangePickerViewController.minimumDate = minDate
        dateRangePickerViewController.maximumDate = Date()
        
        dateRangePickerViewController.selectedColor = InnoThemeManager.shared.selectedTheme!.layoutAssets.buttonDoneActiveColor
        dateRangePickerViewController.cellHighlightedColor = InnoThemeManager.shared.selectedTheme!.layoutAssets.fadedThemeColor
        dateRangePickerViewController.todaySelectedColor = InnoThemeManager.shared.selectedTheme!.layoutAssets.buttonDoneActiveColor
        dateRangePickerViewController.selectedLabelColor = UIColor.white
        dateRangePickerViewController.titleText = "Select Date Range"

           // dateRangePickerViewController.selectedStartDate = selectedStartDate
           // dateRangePickerViewController.selectedEndDate = selectedEndDate
            
           
        let dateFormatter = DateFormatter()
//        let date = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .current

//        var arrStrDates = [String]()
//        var currentDate:Date?
//        let days = Calendar.current.numberOfDaysBetween(Date(), and: lastDayOfMonth1())
//        for i in 0..<days {
//            let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: (i == 0 ? Date() : currentDate)!)
//            currentDate = nextDate
//            arrStrDates.append(dateFormatter.string(from: nextDate!))
//        }
//        var arrDisabledDates = [Date]()
//        for str in arrStrDates {
//            arrDisabledDates.append(dateFormatter.date(from: str)!)
//        }
        //dateRangePickerViewController.disabledDates = arrDisabledDates as? [Date]

        // get the last section and row of collectionview
        let navigationController = UINavigationController(rootViewController: dateRangePickerViewController)
        dateRangePickerViewController.collectionView.scrollToItem(at: IndexPath(row: dateRangePickerViewController.collectionView.numberOfItems(inSection: dateRangePickerViewController.collectionView.numberOfSections - 1) - 1, section: dateRangePickerViewController.collectionView.numberOfSections - 1), at: .bottom, animated: false)

        target.navigationController?.present(navigationController, animated: true, completion: nil)
        dateRangeCompletion = completion
    }
    */
    
    func showCalendar(with minDate:Date, maxDate:Date, target: UIViewController,completion:DateRangeCompletionBlock?) {
            
        dateRangePickerViewController = CalendarDateRangePickerViewController(collectionViewLayout: UICollectionViewFlowLayout())
          //  dateRangePickerViewController.cellFont = UIFont(name: "Montserrat-Regular", size: 15.0)!
            
            
        dateRangePickerViewController.delegate = self
        dateRangePickerViewController.minimumDate = minDate
        dateRangePickerViewController.maximumDate = Date()
        
        dateRangePickerViewController.selectedColor = UIColor.init(hexString: "#1093FF")
        dateRangePickerViewController.cellHighlightedColor = UIColor(red: 59.0/255.0, green: 155.0/255.0, blue: 166.0/255.0, alpha: 1.0).withAlphaComponent(0.5)
        dateRangePickerViewController.todaySelectedColor = UIColor.init(hexString: "#1093FF")
        dateRangePickerViewController.selectedLabelColor = UIColor.white
        dateRangePickerViewController.titleText = "Select Date Range"

           // dateRangePickerViewController.selectedStartDate = selectedStartDate
           // dateRangePickerViewController.selectedEndDate = selectedEndDate
            
           
        let dateFormatter = DateFormatter()
//        let date = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .current

        var arrStrDates = [String]()
        var currentDate:Date?
        let days = Calendar.current.numberOfDaysBetween(Date(), and: lastDayOfMonth1())
        for i in 0..<days {
            let nextDate = Calendar.current.date(byAdding: .day, value: 1, to: (i == 0 ? Date() : currentDate)!)
            currentDate = nextDate
            arrStrDates.append(dateFormatter.string(from: nextDate!))
        }
        var arrDisabledDates = [Date]()
        for str in arrStrDates {
            arrDisabledDates.append(dateFormatter.date(from: str)!)
        }
        dateRangePickerViewController.disabledDates = arrDisabledDates as? [Date]

        // get the last section and row of collectionview
        let navigationController = UINavigationController(rootViewController: dateRangePickerViewController)
        dateRangePickerViewController.collectionView.scrollToItem(at: IndexPath(row: dateRangePickerViewController.collectionView.numberOfItems(inSection: dateRangePickerViewController.collectionView.numberOfSections - 1) - 1, section: dateRangePickerViewController.collectionView.numberOfSections - 1), at: .bottom, animated: false)

        target.navigationController?.present(navigationController, animated: true, completion: nil)
        dateRangeCompletion = completion
    }
    
    func lastDayOfMonth1() -> Date{
       let calendar = Calendar.current
       let components = DateComponents(day:1)
       let startOfNextMonth = calendar.nextDate(after:Date(), matching: components, matchingPolicy: .nextTime)!
       return calendar.date(byAdding:.day, value: -1, to: startOfNextMonth)!
    }
}

extension DateSelectionHelper: CalendarDateRangePickerViewControllerDelegate{
    func didCancelPickingDateRange() {
        
        dateRangeCompletion!(nil,nil,true)
        dateRangePickerViewController.dismiss(animated: true, completion: nil)
        
    }
    
    func didPickDateRange(startDate: Date!, endDate: Date!) {
        dateRangeCompletion!(startDate,endDate,false)
        dateRangePickerViewController.dismiss(animated: true, completion: nil)
    }
    
    func didSelectStartDate(startDate: Date!) {
        
    }
    
    func didSelectEndDate(endDate: Date!) {
        
    }
}
extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
}
