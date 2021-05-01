public inherited sharing class CollectionUtils {
    
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

    private static String getSObjectTypeFromList(List<SObject> listToProcess) {
        return (!listToProcess.isEmpty())
            ? String.valueOf(listToProcess[0]?.getSObjectType())
            : 'sObject';
    }
}

