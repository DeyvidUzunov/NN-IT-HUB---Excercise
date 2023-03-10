public class UpdateCountryValues {
    @future(callout=true) public static void calloutUpdateCountry(){
    
        //List of countries retrieved via API.
        List<Country__c> countriesToUpdate = CountryLayerAPI.getCountries();
      	//List of existing countries.
        List<Country__c> existingCountries = [SELECT Id, Name, CountryISOCode2__c, CountryISOCode3__c, Capital__c, Region__c, Subregion__c, RegionalBlocs__c FROM Country__c];
        //List to store any country that needs to be updated or added.
		List<Country__c> countriesToUpsert = new List<Country__c>();
        
		// Create a map of the existing countries for easy lookup
		Map<String, Country__c> existingCountryMap = new Map<String, Country__c>();
		for (Country__c country : existingCountries) {
    		existingCountryMap.put(country.CountryISOCode2__c, country);
		}

		// Loop through each country to update and compare it with the existing record
		for (Country__c countryToUpdate : countriesToUpdate) {
    		Country__c existingCountry = existingCountryMap.get(countryToUpdate.CountryISOCode2__c);
    
    	// If the existing country record exists and has different fields, add to be updated
   		 if (existingCountry != null &&
        	(existingCountry.Name != countryToUpdate.Name ||
        	existingCountry.CountryISOCode3__c != countryToUpdate.CountryISOCode3__c ||
         	existingCountry.Capital__c != countryToUpdate.Capital__c ||
         	existingCountry.Region__c != countryToUpdate.Region__c ||
         	existingCountry.Subregion__c != countryToUpdate.Subregion__c ||
         	existingCountry.RegionalBlocs__c != countryToUpdate.RegionalBlocs__c)) {
        
        	existingCountry.Name = countryToUpdate.Name;
        	existingCountry.CountryISOCode3__c = countryToUpdate.CountryISOCode3__c;
        	existingCountry.Capital__c = countryToUpdate.Capital__c;
        	existingCountry.Region__c = countryToUpdate.Region__c;
        	existingCountry.Subregion__c = countryToUpdate.Subregion__c;
        	existingCountry.RegionalBlocs__c = countryToUpdate.RegionalBlocs__c;
        
			countriesToUpsert.add(existingCountry);
    		}else if (existingCountry == null) {
        		countriesToUpsert.add(countryToUpdate);
    		}
		}
	
    }
}