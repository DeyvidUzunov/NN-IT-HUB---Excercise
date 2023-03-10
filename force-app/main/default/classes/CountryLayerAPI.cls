public class CountryLayerAPI {

    private static final CountryLayerSettings__mdt SETTINGS = CountryLayerSettings__mdt.getInstance('API');
   	private static final String API_URL = 'http://api.countrylayer.com/v2/all?access_key=' + SETTINGS.API__c;

    public static void updateCountries() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(API_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        List<Country__c> countries = new List<Country__c>();
        if (response.getStatusCode() == 200) {
            List<Object> jsonResponse = (List<Object>) JSON.deserializeUntyped(response.getBody());
            for (Object obj : jsonResponse) {
                
                Map<String, Object> countryData = (Map<String, Object>) obj;
                Country__c country = new Country__c();
                country.Name = (String) countryData.get('name');
                country.CountryISOCode2__c = (String) countryData.get('alpha2Code');
                country.CountryISOCode3__c = (String) countryData.get('alpha3Code');
                country.Capital__c = (String) countryData.get('capital');
                country.Region__c = (String) countryData.get('region');
                country.Subregion__c = (String) countryData.get('subregion');
                List<Object> regionalBlocs = (List<Object>) countryData.get('regionalBlocs');
                if (regionalBlocs != null) {
                    List<String> blocAcronyms = new List<String>();
                    for (Object blocObj : regionalBlocs) {
                        Map<String, Object> blocData = (Map<String, Object>) blocObj;
                        String acronym = (String) blocData.get('acronym');
                        if (acronym != null) {
                            blocAcronyms.add(acronym);
                        }
                    }
                    if (!blocAcronyms.isEmpty()) {
                        country.regionalBlocs__c = String.join(blocAcronyms, ';');
                    }
                }
                
                countries.add(country);
            }
            insert countries;
        }
    }
    
    public static List<Country__c> getCountries() {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(API_URL);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        List<Country__c> countries = new List<Country__c>();
        if (response.getStatusCode() == 200) {
            List<Object> jsonResponse = (List<Object>) JSON.deserializeUntyped(response.getBody());
            for (Object obj : jsonResponse) {
                
                Map<String, Object> countryData = (Map<String, Object>) obj;
                Country__c country = new Country__c();
                country.Name = (String) countryData.get('name');
                country.CountryISOCode2__c = (String) countryData.get('alpha2Code');
                country.CountryISOCode3__c = (String) countryData.get('alpha3Code');
                country.Capital__c = (String) countryData.get('capital');
                country.Region__c = (String) countryData.get('region');
                country.Subregion__c = (String) countryData.get('subregion');
                List<Object> regionalBlocs = (List<Object>) countryData.get('regionalBlocs');
                if (regionalBlocs != null) {
                    List<String> blocAcronyms = new List<String>();
                    for (Object blocObj : regionalBlocs) {
                        Map<String, Object> blocData = (Map<String, Object>) blocObj;
                        String acronym = (String) blocData.get('acronym');
                        if (acronym != null) {
                            blocAcronyms.add(acronym);
                        }
                    }
                    if (!blocAcronyms.isEmpty()) {
                        country.regionalBlocs__c = String.join(blocAcronyms, ';');
                    }
                }
                
                countries.add(country);
            }
            return countries;
        }else{
            return null;
        }
    }

}