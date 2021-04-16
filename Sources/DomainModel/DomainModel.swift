struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    let amount : Int
    let currency : String
    
    init(amount am: Int,currency curr: String) {
        self.amount = am
        self.currency = curr
        
        /*
        if(curr != "USD" || curr != "GBP" || curr != "EUR" || curr != "CAN"){
            return nil
        }
         */
    }
    
    func convert(_ currency_change: String) -> Money {
        var dollars = 0.0
        
        if(currency == "GBP") {
            
            dollars = Double(amount) / 0.5
            
        } else if (currency == "EUR") {
            
            dollars = Double(amount) / 1.5
            
        } else if (currency == "CAN") {
            
            dollars = Double(amount) / 1.25
            
        } else{
            dollars = Double(amount)
        }
        
        var final = 0.0
        
        if(currency_change == "GBP") {
            
            final = dollars * 0.5
            
        } else if (currency_change == "EUR") {
            
            final = dollars * 1.5
            
        } else if (currency_change == "CAN") {
            
            final = dollars * 1.25
            
        } else {
            
            final = dollars
            
        }
        
        final.round()
        return Money(amount: Int(final), currency: currency_change)
    }

    func add(_ money2: Money) -> Money {
        
        var save = 0
        
        if(self.currency == money2.currency) {
            save = self.amount + money2.amount
            return Money(amount: save, currency: currency)
        }else{
            let test = self.convert(money2.currency)
            save = test.amount + money2.amount
            
        }
        return Money(amount: save, currency: money2.currency)
    }
    
    func subtract(_ money2: Money) -> Money {
        
        var save = 0
        
        if(self.currency == money2.currency) {
            save = self.amount - money2.amount
            return Money(amount: save, currency: currency)
        }else{
            self.convert(money2.currency)
            save = self.amount - money2.amount
            
        }
        return Money(amount: save, currency: self.currency)
    }
    
}

////////////////////////////////////
// Job
//
public class Job {
    
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    
    let title : String
    var type: JobType
    
    init(title t: String, type ty: JobType) {
        self.title = t
        self.type = ty
    }
    
    func calculateIncome(_ hours: Int) -> Int{
        switch self.type {
            case .Hourly(let wage):
                var test = wage * Double(hours)
                test.round()
                return Int(test)
            case .Salary(let salary):
                return Int(salary)
        }
    }
    
    
    func raise(byPercent byPercent: Double) {
        switch self.type {
        case .Hourly(let wage):
            var final = (wage*(byPercent+1.0))
            final.round()
            self.type = JobType.Hourly(final)
        case .Salary(let salary):
            self.type = JobType.Salary(UInt((Double(salary)) * (byPercent + 1.0)))
        }
    }
    
    func raise(byAmount byAmount: Int) {
            switch self.type {
            case .Hourly(let wage):
                var final = wage+Double(byAmount)
                final.round()
                self.type = JobType.Hourly(final)
            case .Salary(let salary):
                self.type = JobType.Salary(UInt(Int(salary) + byAmount))
            }
        }
    
    func raise(byAmount byAmount: Double) {
        switch self.type {
            case .Hourly(let wage):
                var final = wage+(byAmount)
                final.round()
                self.type = JobType.Hourly(final)
            case .Salary(let salary):
                self.type = JobType.Salary(UInt((Double(salary)) + byAmount))
        }
    }
    
    
}

////////////////////////////////////
// Person
//
public class Person {
    let firstName: String
    let lastName: String
    let age: Int
    var job: Job? = nil{
        didSet{
            if (age <= 16){
                job = nil
            }
        }
    }
    var spouse: Person? = nil{
        didSet{
            if (age <= 16){
                spouse = nil
            }
        }
    }
    

    
    init(firstName fn: String, lastName ln: String, age a: Int) {
        self.firstName = fn
        self.lastName = ln
        self.age = a
    }
    
    func toString() -> String {
        let sentence = "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(String(describing: self.job)) spouse:\(String(describing: self.spouse))]"
        
        
        
        return sentence
    }
    
}

////////////////////////////////////
// Family
//
public class Family {
    
    var members: [Person]
    
    init(spouse1: Person, spouse2: Person){
        if((spouse1.spouse != nil) || (spouse2.spouse != nil)) {
            self.members = []
            return
        }
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        self.members = [spouse1, spouse2]
    }
    
    func haveChild(_ children: Person) -> Bool{
        if((self.members[0].age < 21) && (self.members[1].age < 21)){
            return false
        }
        self.members.append(children)
        return true
    }
    
    func householdIncome() -> Int {
        var total: Int = 0
        
        for each in members {
            if (each.job != nil) {
                total += each.job!.calculateIncome(2000)
            }
        }
        return total
    }
}


/*
 didSet {
             if age < 16 {
                 spouse = nil
             }
         }
 */
