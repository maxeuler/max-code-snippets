public with sharing class SObjectUtils {
    
    /**
     *  Perform a delete operation on a set of IDs without a query
     */
    public static List<SObject> populateSObjectListByIdSet(Set<ID> idSet) {
        List<SObject> sObjectList = new List<SObject>();
        for (ID recordId : idSet) {
            sObjectList.add(
                recordId.getSobjectType().newSObject(recordId)
            );
        }
        return sObjectList;
    }
}
