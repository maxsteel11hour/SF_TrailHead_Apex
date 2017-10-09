@isTest
private class TestRestrictContactByName {
	//static List<List<Database.SaveResult>> sResult_i = Test_action(); 
//	static List<Database.SaveResult> sResult_u = Test_beforeUpdate();  

    //It seems for each @isTest a new call is invoked and the data between each @isTest cannot be shared
    //Each test needs to be independent of the other. Thus mod. would be needed to 
    //	1. invoke Test_action from test
    //	2. Arguments {Action_Type, }
    
    @isTest static void Test_validate_i_0(){
		Test_action('Insert',0);
/*        System.Debug('sResult_i     size = '+ sResult_i.size());
        System.Debug('sResult_i [0] size = '+ sResult_i[0].size());
        System.Debug('sResult_i [1] size = '+ sResult_i[1].size()); */       
        //Test_validate(sResult_i[0][0]);
    }
/**/
    @isTest static void Test_validate_i_1(){
        Test_action('Insert',1);
        //Test_validate(sResult_i[0][1]);        
    }  

    @isTest static void Test_validate_i_2(){
		Test_action('Insert',2);
        //Test_validate(sResult_i[0][2]);        
    }        
    @isTest static void Test_validate_i_3(){
		Test_action('Insert',3);
        //Test_validate(sResult_i[0][3]);        
    }
   
    @isTest static void Test_validate_u_0(){
		Test_action('Update',0);
        //Test_validate(sResult_u[0]);        
    }
    @isTest static void Test_validate_u_1(){
		Test_action('Update',1);
        //Test_validate(sResult_u[1]);        
    }        
    @isTest static void Test_validate_u_2(){
		Test_action('Update',2);
        //Test_validate(sResult_u[2]);        
    }        
    @isTest static void Test_validate_u_3(){
		Test_action('Update',3);
        //Test_validate(sResult_u[3]);        
    } 
   
    static List<Contact> Test_beforeInsert(Integer i){   
        List<Contact> sCon      = new List<Contact>();
        List<String>  sLastName = new List<String> {'BENIGN', 'INVALIDNAME','INVALID', 'INVALIdnAME'};
        /*    
        for (Integer i = 0; i<sLastName.size(); i++ ){
            sCon.add(new Contact(FirstName = 'Invalid_'+i, LastName= sLastName[i]));
            system.debug('INSERT['+i+']');
        } */ 
        sCon.add(new Contact(FirstName = 'Invalid_'+i, LastName= sLastName[i]));
        System.Debug('Contact Insert Record size ='+sCon.size());
        return sCon;
    }
    
    static List<Contact> Test_beforeUpdate(Integer i){   
        List<String>  sLastName = new List<String> {'BENIGN', 'INVALIDNAME','INVALID', 'INVALIdnAME'};
        List<Contact> sCon      = new List<Contact>();
        /*
        for(Integer i = 0; i<6; i++){
        	sCon.add(new Contact(FirstName='TempF_'+i, LastName='TempL'+i));
        } */
        sCon.add(new Contact(FirstName='TempF_'+i, LastName='TempL'+i));
        insert sCon;
        sCon.clear();
        //SOQL in Test mode cannot access the real database but uses its own sandbox. hence we created test data
        sCon.addAll([Select FirstName,LastName from Contact where LastName like '%TempL%' Limit 1]);
        
        /*Integer i               = 0;
        for (Contact x : sCon){
            x.LastName = sLastName[i];
            system.debug('Update['+i+']');
            i += 1;
        }*/
        sCon[0].LastName = sLastName[i];
        System.Debug('Update['+i+']');        
        System.Debug('Contact Update Record size ='+sCon.size());        

        return sCon;
    }
    
	static void Test_action(String sAction, Integer sElement){
        System.Debug('Invoke');
 		List<Contact> sCon = new List<Contact>();
        
        if (sAction == 'Insert'){

            sCon = Test_beforeInsert(sElement);          
            System.Debug('Insert Contact Size ='+sCon.size());
        }
        else{
            sCon = Test_beforeUpdate(sElement);            
            System.Debug('Update Contact Size ='+sCon.size());
        }
        
        Test.startTest();
        List<Database.SaveResult> sResult = new List<Database.SaveResult>();	
        //List<Database.SaveResult> sResult_u1 = new List<Database.SaveResult>();	
        	if (sAction == 'Insert'){
                sResult = Database.insert(sCon, false); }
        	else{
                sResult = Database.update(sCon, false); }           
        Test.stopTest(); 

        //List<List<Database.SaveResult>> sResult = new List<List<Database.SaveResult>>();
        //sResult.add(sResult_i1);
        //sResult.add(sResult_u1);
		Test_validate(sResult[0]);
    }

    static void Test_validate(Database.SaveResult x){
        	//System.debug('Success - '+x.isSuccess());

        if (x.isSuccess()){
        	System.assert(x.isSuccess());
        }
        else{
            //System.debug('Error Size = '+x.getErrors().size());	
            System.assert(x.getErrors().size() > 0);        
            
            String sErrorMsg = 'The Last Name "INVALIDNAME" is not allowed for DML';
            String sOutput   = x.getErrors()[0].getMessage();
                //System.Debug('Error Message ='+sOutput);
            System.assertNotEquals(sErrorMsg.uncapitalize(),sOutput.uncapitalize());            
        }
    }    
}