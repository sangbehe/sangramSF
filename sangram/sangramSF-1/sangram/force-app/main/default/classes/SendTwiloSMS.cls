public class SendTwiloSMS {
 		 
    public static final String FromMobile ='12545276541';
    public static final String AccountSID ='AC6c32e2dc4591fe8b2dc0166e7c79a999';
    public static final String Authtoken ='37fbfe99f7aec055f391ee8c74815982';
    @Future(callout=true)
    @AuraEnabled
 public static Void messageAPI(String ToMobile,String AccountName,String Message)
 { 
 String Crediential = EncodingUtil.base64Encode(Blob.valueOf(AccountSID + ':' + Authtoken));
 String EndPoint = 'https://api.twilio.com/2010-04-01/Accounts/'+AccountSID+'/Messages.json';
 String Body;
 String responseBody;
 if(ToMobile != '' && Message=='new')
 {
 Body = 'To='+ToMobile+'&amp;amp;'+
 'From='+FromMobile+'&amp;amp;'+
 'Body='+'Great News ! A Customer. '+AccountName+' will get VIP treatment';
 }
     else{
  Body = 'To='+ToMobile+'&amp;amp;'+
 'From='+FromMobile+'&amp;amp;'+
 'Body='+Message;
   }
     system.debug('request body'+Body);

 Http h = new Http();
 HttpRequest request = new HttpRequest();
 request.setHeader('Content-Type', 'application/x-www-form-urlencoded');
 request.setHeader('Authorization', 'Basic '+ Crediential);
 request.setEndpoint(EndPoint);
 request.setMethod('POST');
 request.setBody(Body);
 HttpResponse res = h.send(request);
 responseBody = res.getBody();
 
}}