global class ScheduleUpdateCountry implements Schedulable {
    global void execute(SchedulableContext SC) {
        UpdateCountryValues.calloutUpdateCountry();
    }  
}