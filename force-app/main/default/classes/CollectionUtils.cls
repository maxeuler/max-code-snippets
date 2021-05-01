public inherited sharing class CollectionUtils {
    
    /**
     * @param key field which should be used as the key in the map (has to be an id field)
     * @param listToProcess a list of sobjects
     * @example 
     * Contact[] contacts = [SELECT AccountId, firstName, lastName FROM Contact LIMIT 50];
     * Map<Id, Contact> contactsByAccountId = (Map<Id, Contact>) CollectionUtils.idMapFromCollectionByKey('accountId', contacts);
     */
    public static Map<Id, SObject> idMapFromCollectionByKey(
        String key, 
        List<SObject> listToProcess
    ) {
        String objectType = getSObjectTypeFromList(listToProcess);
        Type dynamicMapType = Type.forName('Map<Id,' + objectType + '>');

        Map<Id, SObject> recordsByKey = (Map<Id, SObject>) dynamicMapType.newInstance();
        for (SObject currentRecord : listToProcess) {
            if (currentRecord.get(key) != null) {
                recordsByKey.put((Id) currentRecord.get(key), currentRecord);
            }
        }

        return recordsByKey;
    }

    /**
     * @param key field which should be used as the key in the map (has to be an string field)
     * @param listToProcess a list of sobjects
     * @example 
     * Contact[] contacts = [SELECT AccountId, firstName, lastName FROM Contact LIMIT 50];
     * Map<String, Contact> contactsByAccountId = (Map<String, Contact>) CollectionUtils.StringMapFromCollectionByKey*('shippingStreet', contacts);
     */
    public static Map<String, SObject> stringMapFromCollectionByKes(
        String key,
        List<SObject> listToProcess
    ) {
        String objectType = getSObjectTypeFromList(listToProcess);
        Type dynamicMapType = Type.forName('Map<String,' + objectType + '>');

        Map<String, SObject> recordsByKey = (Map<String, SObject>) dynamicMapType.newInstance();
        for (SObject currentRecord : listToProcess) {
            if (currentRecord.get(key) != null) {
                recordsByKey.put((String) currentRecord.get(key), currentRecord);
            }
        }

        return recordsByKey;
    }

    private static String getSObjectTypeFromList(List<SObject> listToProcess) {
        return (!listToProcess.isEmpty())
            ? String.valueOf(listToProcess[0]?.getSObjectType())
            : 'sObject';
    }
}

