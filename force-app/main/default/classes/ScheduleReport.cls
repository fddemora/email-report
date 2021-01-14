global with sharing class ScheduleReport {  
    @future(callout=true)
    public static void run() {
        try{
            List<Report> reportList = [SELECT Id, Name from Report WHERE Name = 'Supplies'];
            if((reportList.size() > 0)){ 
                String reportId = (String) reportList.get(0).get('Id');
                String reportName = (String) reportList.get(0).get('Name');
                String url = URL.getSalesforceBaseUrl().toExternalForm()+'/servlet/PrintableViewDownloadServlet?isdtp=p1&reportId='+reportId;
                ApexPages.PageReference objPage = new ApexPages.PageReference(url);

                Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                email.setSubject(reportName);

                Messaging.EmailFileAttachment objMsgEmailAttach = new Messaging.EmailFileAttachment();
                objMsgEmailAttach.setFileName(reportName + '.csv');
                objMsgEmailAttach.setBody(objPage.getContent());
                objMsgEmailAttach.setContentType('text/csv');
                
                List<Messaging.EmailFileAttachment> attach = new List<Messaging.EmailFileAttachment>();
                attach.add(objMsgEmailAttach);
                email.setFileAttachments(attach);

                List<String> toAddresses = new List<String>();
                toAddresses.add('demoraes@test.com');
                email.setToAddresses(toAddresses);
                email.setSenderDisplayName('Fellipe from Apex');

                String body = 'Hello, <br/><br/> Here is attached '+reportName+'.<br/><br/>Thank You.<br/>Admin';
                email.setHtmlBody(body);

                Messaging.SendEmailResult[] res = Messaging.sendEmail(new Messaging.Email[] { email });
                System.debug('email sent');
                System.debug(res[0].isSuccess());
            }
        }
        catch(Exception ex) {
            System.debug(ex.getMessage());
        }
    }
}

/**
 * output of line 7 downloads the report to a .xlsx file.
*/