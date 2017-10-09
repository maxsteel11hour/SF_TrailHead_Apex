@isTest 
private class TestVerifyDate {

    @isTest static void Test_Checknull1(){
        
        Date sReturnDate = VerifyDate.CheckDates(null,null);
        System.assertEquals(null,sReturnDate);
    }
    @isTest static void Test_Checknull2(){
        Date sReturnDate = VerifyDate.CheckDates(null,date.newInstance(0, 0, 0));
        System.assertEquals(null,sReturnDate);
    }
    @isTest static void Test_Checknull3(){
        Date sReturnDate = VerifyDate.CheckDates(date.newInstance(0, 0, 0),date.newInstance(0, 0, 0));
        System.assertEquals(date.newInstance(0, 0, 0),sReturnDate); 
    }
    @isTest static void Test_Date1_Date2same(){
        Date sReturnDate = VerifyDate.CheckDates(date.newInstance(2000, 01, 01),date.newInstance(2000, 01, 01));
        System.assertEquals(date.newInstance(2000, 01, 01),sReturnDate);
    }
    //plain month check _ outside next 30day - date 1 > date 2
    @isTest static void Test_Date1gt_Date2_1(){
        Date sReturnDate = VerifyDate.CheckDates(date.newInstance(2000, 01, 31),date.newInstance(2000, 01, 01));
        System.assertEquals(date.newInstance(2000, 01, 31),sReturnDate);
    }
    //inter month check + leap year check _ outside next 30day - date 1 > date 2
    @isTest static void Test_Date1gt_Date2_2(){
        Date sReturnDate = VerifyDate.CheckDates(date.newInstance(2000, 02, 15),date.newInstance(2000, 01, 01));
        System.assertEquals(date.newInstance(2000, 02, 29),sReturnDate);
    }
    //plain month check _ inside next 30day - date 1 > date 2
    @isTest static void Test_Date1gt_Date2_3(){
        Date sReturnDate = VerifyDate.CheckDates(date.newInstance(2000, 01, 02),date.newInstance(2000, 01, 01));
        System.assertEquals(date.newInstance(2000, 01, 31),sReturnDate);
    }
    //inter month check _ inside next 30day - date 1 > date 2
    @isTest static void Test_Date1gt_Date2_4(){
        Date sReturnDate = VerifyDate.CheckDates(date.newInstance(2000, 02, 15),date.newInstance(2000, 01, 31));
        System.assertEquals(date.newInstance(2000, 02, 29),sReturnDate);
    }
    //plain month check _ outside next 30day - date 1 < date 2
    @isTest static void Test_Date1_Date2gt_1(){
        Date sReturnDate = VerifyDate.CheckDates(date.newInstance(2000, 01, 01),date.newInstance(2000, 01, 31));
        System.assertEquals(date.newInstance(2000, 01, 31),sReturnDate);
    }
    //inter month check + leap year check _ outside next 30day - date 1 < date 2
    @isTest static void Test_Date1_Date2gt_2(){
        Date sReturnDate = VerifyDate.CheckDates(date.newInstance(2000, 01, 01),date.newInstance(2000, 02, 29));
        System.assertEquals(date.newInstance(2000, 01, 31),sReturnDate);
    }
    //plain month check _ inside next 30day - date 1 < date 2
    @isTest static void Test_Date1_Date2gt_3(){
        Date sReturnDate = VerifyDate.CheckDates(date.newInstance(2000, 01, 01),date.newInstance(2000, 01, 15));
        System.assertEquals(date.newInstance(2000, 01, 15),sReturnDate);
    }
    //inter month check _ inside next 30day - date 1 < date 2
    @isTest static void Test_Date1_Date2gt_4(){
        Date sReturnDate = VerifyDate.CheckDates(date.newInstance(2000, 01, 31),date.newInstance(2000, 02, 02));
        System.assertEquals(date.newInstance(2000, 02, 02),sReturnDate);
    }
}
