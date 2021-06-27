@isTest
private class TriggerHandler_Test {
    private static String lastMethodCalled;
    private static TriggerHandler_Test.TestHandler handler;
    
    static {
        handler = new TriggerHandler_Test.TestHandler();
        handler.isTriggerExecuting = true;
    }

    @isTest
    static void testBeforeInsert() {
        handler.setTriggerContext('before insert');
        handler.execute();
        System.assertEquals(
            'beforeInsert',
            lastMethodCalled,
            'Last method should be beforeInsert'
        );
    }

    @isTest
    static void testGetHandlerName() {
        System.assertEquals(
            'TestHandler',
            handler.getHandlerName(),
            'Handler name should match class name'
        );
    }

    private class TestHandler extends TriggerHandler {
        public override void beforeInsert() {
            TriggerHandler_Test.lastMethodCalled = 'beforeInsert';
        }

        public override void beforeUpdate() {
            TriggerHandler_Test.lastMethodCalled = 'beforeUpdate';
        }

        public override void beforeDelete() {
            TriggerHandler_Test.lastMethodCalled = 'beforeDelete';
        }

        public override void afterInsert() {
            TriggerHandler_Test.lastMethodCalled = 'afterInsert';
        }

        public override void afterUpdate() {
            TriggerHandler_Test.lastMethodCalled = 'afterUpdate';
        }

        public override void afterDelete() {
            TriggerHandler_Test.lastMethodCalled = 'afterDelete';
        }

        public override void afterUndelete() {
            TriggerHandler_Test.lastMethodCalled = 'afterUndelete';
        }
    }
}
