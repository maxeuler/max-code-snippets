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
    public static Map<String, SObject> stringMapFromCollectionByKey(
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

    /**
     * @param key field which should be used as the key in the map (has to be an id field)
     * @param listToProcess a list of sobjects
     * @example 
     * Contact[] contacts = [SELECT AccountId, firstName, lastName FROM Contact LIMIT 50];
     * Map<Id, List<Contact>> contactsByAccountId = (Map<Id, List<Contact>>) CollectionUtils.idMapFromCollectionByKey('accountId', contacts);
     */
    public static Map<Id, List<SObject>> mapFromCollectionWithCollectionValues(
        String key,
        List<SObject> listToProcess
    ) {
        String objectType = getSObjectTypeFromList(listToProcess);
        Type dynamicListType = Type.forName('List<' + objectType + '>');
        Type dynamicMapType = Type.forName('Map<Id, List<' + objectType + '>>');

        Map<Id, List<SObject>> recordListsByKey = (Map<String, List<SObject>>) dynamicMapType.newInstance();
        for (SObject currentRecord : listToProcess) {
            if (currentRecord.get(key) != null) {
                if (recordListsByKey.containsKey((Id) currentRecord.get(key))) {
                    List<SObject> existingList = (List<SObject>) recordListsByKey.get(
                        (Id) currentRecord.get(key)
                    );
                    existingList.add(currentRecord);
                    recordListsByKey.put((Id) currentRecord.get(key), existingList);
                } else {
                    List<SObject> newList = (List<SObject>) dynamicListType.newInstance();
                    newList.add(currentRecord);
                    recordListsByKey.put((id) currentRecord.get(key), newList);
                }
            }
        }

        return recordListsByKey;
    }

    private static String getSObjectTypeFromList(List<SObject> listToProcess) {
        return (!listToProcess.isEmpty())
            ? String.valueOf(listToProcess[0]?.getSObjectType())
            : 'sObject';
    }
}

