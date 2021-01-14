@isTest
private with sharing class ScheduleReportTest {
    @isTest static void test1(){

        ScheduleReportClass p = new ScheduleReportClass();
        System.schedule('merge', '0 0 * * * ?', p);

        Test.startTest();
        new ScheduleReportClass();
        Test.stopTest();

        System.assertEquals(1,[SELECT Id, StartTime FROM CronTrigger].size(), 'CronTrigger size is not 1.');
        List<Report> rep1 = [SELECT Name, Id FROM Report];
        System.assertEquals(0,rep1.size(), 'list size does not match.');
    }
}
