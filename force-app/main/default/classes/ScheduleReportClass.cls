global with sharing class ScheduleReportClass implements Schedulable {
    global void execute(SchedulableContext context) {
         ScheduleReport.run();
    }

}
