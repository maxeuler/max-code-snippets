/**
 * This is an example of using the singleton pattern to retrieve data in a manner
 * that is bulkified and thats allows us to reuse this data accross a whole
 * transaction
 * This example uses the Sales_Tax_City__mdt Metadata type
 */

public without sharing class SingletonExample {
    private static SingletonExample instance;
    private Sales_Tax_City__mdt metadata;
    
    private SingletonExample() {
        // private constructor so that the getInstance Method is the only way 
        // to create a new instance of this class
    }

    public static SingletonExample getInstance() {
        if (instance == null) {
            instance = new SingletonExample();
        }
        return instance;
    }

    public Sales_Tax_City__mdt getMetadata() {
        if (metadata == null) {
            metadata = [SELECT ID FROM Sales_Tax_City__mdt LIMIT 1];
        }
        return metadata;
    }
}
