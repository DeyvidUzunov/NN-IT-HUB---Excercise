@isTest
private class UpdateCountryValuesTest {
    @isTest
    static void testCalloutUpdateCountry() {
        // Mock HTTP callout
        Test.setMock(HttpCalloutMock.class, new CountryLayerAPIMock());

        // Create existing countries
        List<Country__c> existingCountries = new List<Country__c>{
            new Country__c(Name = 'United States', CountryISOCode2__c = 'US', CountryISOCode3__c = 'USA', Capital__c = 'Washington D.C.'),
            new Country__c(Name = 'Canada', CountryISOCode2__c = 'CA', CountryISOCode3__c = 'CAN', Capital__c = 'Ottawa')
        };
        insert existingCountries;

        // Call the method
        Test.startTest();
        // Schedule the job to run in 1 hour from now
        Datetime now = Datetime.now();
        Datetime futureTime = now.addHours(1);
        String cronExp = '' + futureTime.second() + ' ' + futureTime.minute() + ' ' + futureTime.hour() + ' ' + futureTime.day() + ' ' + futureTime.month() + ' ? ' + futureTime.year();
        System.schedule('Test ScheduleUpdateCountry', cronExp, new ScheduleUpdateCountry());
        Test.stopTest();

        // Verify that the countries were updated correctly
        List<Country__c> countries = [SELECT Id, Name, CountryISOCode2__c, CountryISOCode3__c, Capital__c, Region__c, Subregion__c, RegionalBlocs__c FROM Country__c];
        System.assertEquals(2, countries.size());
        System.assertEquals('United States', countries[0].Name);
        System.assertEquals('US', countries[0].CountryISOCode2__c);
        System.assertEquals('USA', countries[0].CountryISOCode3__c);
        System.assertEquals('Washington D.C.', countries[0].Capital__c);
        System.assertEquals(null, countries[0].Region__c);
        System.assertEquals(null, countries[0].Subregion__c);
        System.assertEquals(null, countries[0].RegionalBlocs__c);
        System.assertEquals('Canada', countries[1].Name);
        System.assertEquals('CA', countries[1].CountryISOCode2__c);
        System.assertEquals('CAN', countries[1].CountryISOCode3__c);
        System.assertEquals('Ottawa', countries[1].Capital__c);
        System.assertEquals(null, countries[1].Region__c);
        System.assertEquals(null, countries[1].Subregion__c);
        System.assertEquals(null, countries[1].RegionalBlocs__c);
    }

    private class CountryLayerAPIMock implements HttpCalloutMock {
        public HttpResponse respond(HttpRequest req) {
            // Create mock response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('[{"name":"United States","alpha2Code":"US","alpha3Code":"USA","capital":"Washington D.C.","region":"Americas","subregion":"Northern America","regionalBlocs":[{"acronym":"NAFTA","name":"North American Free Trade Agreement"}]},' +
                        '{"name":"Mexico","alpha2Code":"MX","alpha3Code":"MEX","capital":"Mexico City","region":"Americas","subregion":"Central America","regionalBlocs":[{"acronym":"NAFTA","name":"North American Free Trade Agreement"}]},' +
                        '{"name":"Canada","alpha2Code":"CA","alpha3Code":"CAN","capital":"Ottawa","region":"Americas","subregion":"Northern America","regionalBlocs":[{"acronym":"NAFTA","name":"North American Free Trade Agreement"}]}]');
            res.setStatusCode(200);
            return res;
        }
    }
}