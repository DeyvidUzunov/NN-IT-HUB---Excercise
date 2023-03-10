@isTest
private class CountryLayerAPITest {
    
    // Mock response class
    private class MockHttpResponse implements HttpCalloutMock {
        public HTTPResponse respond(HTTPRequest req) {
            HttpResponse res = new HttpResponse();
            res.setBody('[{"name": "Country1", "alpha2Code": "C1", "alpha3Code": "C1A", "capital": "Capital1", "region": "Region1", "subregion": "Subregion1", "regionalBlocs": [{"acronym": "RB1"}]},'
                        +'{"name": "Country2", "alpha2Code": "C2", "alpha3Code": "C2A", "capital": "Capital2", "region": "Region2", "subregion": "Subregion2", "regionalBlocs": [{"acronym": "RB2"}, {"acronym": "RB3"}]}]');
            res.setStatusCode(200);
            return res;
        }
    }
    
    @isTest
    static void updateCountriesTest() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse());
        CountryLayerAPI.updateCountries();
        List<Country__c> countries = [SELECT Name, CountryISOCode2__c, CountryISOCode3__c, Capital__c, Region__c, Subregion__c, regionalBlocs__c FROM Country__c];
        System.assertEquals(2, countries.size());
        System.assertEquals('Country1', countries[0].Name);
        System.assertEquals('C1', countries[0].CountryISOCode2__c);
        System.assertEquals('C1A', countries[0].CountryISOCode3__c);
        System.assertEquals('Capital1', countries[0].Capital__c);
        System.assertEquals('Region1', countries[0].Region__c);
        System.assertEquals('Subregion1', countries[0].Subregion__c);
        System.assertEquals('RB1', countries[0].regionalBlocs__c);
        System.assertEquals('Country2', countries[1].Name);
        System.assertEquals('C2', countries[1].CountryISOCode2__c);
        System.assertEquals('C2A', countries[1].CountryISOCode3__c);
        System.assertEquals('Capital2', countries[1].Capital__c);
        System.assertEquals('Region2', countries[1].Region__c);
        System.assertEquals('Subregion2', countries[1].Subregion__c);
        System.assertEquals('RB2;RB3', countries[1].regionalBlocs__c);
    }
    
    @isTest
    static void getCountriesTest() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponse());
        List<Country__c> countries = CountryLayerAPI.getCountries();
        System.assertEquals(2, countries.size());
        System.assertEquals('Country1', countries[0].Name);
        System.assertEquals('C1', countries[0].CountryISOCode2__c);
        System.assertEquals('C1A', countries[0].CountryISOCode3__c);
        System.assertEquals('Capital1', countries[0].Capital__c);
        System.assertEquals('Region1', countries[0].Region__c);
        System.assertEquals('Subregion1', countries[0].Subregion__c);
        System.assertEquals('RB1', countries[0].regionalBlocs__c);
    }
}