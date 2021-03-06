public virtual class TriggerHandler {

    protected TriggerContext context;
    @testVisible 
    private Boolean isTriggerExecuting;
    
    private static Set<String> bypassedHandlers;

    static {
        bypassedHandlers = new Set<String>();
    }

    public class TriggerHandlerException extends Exception {
    
    }
    
    public TriggerHandler() {
        this.setExecutionStatus(false);
        this.setTriggerContext();
    }

    public virtual void execute() {
        if (this.shouldRunTrigger()) {
            this.callCorrectHandlerMethod();
        }
    }

    private void setExecutionStatus(Boolean isTestMode) {
        if (!Trigger.isExecuting && !isTestMode) {
            this.isTriggerExecuting = false;
            return;
        } else {
            this.isTriggerExecuting = true;
        }
    }

    protected Boolean shouldRunTrigger() {
        if (!this.isTriggerExecuting || this.context == null) {
            throw new TriggerHandlerException(
                'Trigger handler called outside of Trigger execution'
            );
        }

        if (TriggerHandler.bypassedHandlers.contains(this.getHandlerName())) {
            return false;
        }

        return true;
    }

    @testVisible
    private String getHandlerName() {
        return String.valueOf(this).substring(0, String.valueOf(this).indexOf(':'));
    }

    private void setTriggerContext() {
        switch on Trigger.operationType {
            when BEFORE_INSERT {
                this.context = TriggerContext.BEFORE_INSERT;
            }
            when BEFORE_UPDATE {
                this.context = TriggerContext.BEFORE_UPDATE;
            }
            when BEFORE_DELETE {
                this.context = TriggerContext.BEFORE_DELETE;
            }
            when AFTER_INSERT {
                this.context = TriggerContext.AFTER_INSERT;
            }
            when AFTER_UPDATE {
                this.context = TriggerContext.AFTER_UPDATE;
            }
            when AFTER_DELETE {
                this.context = TriggerContext.AFTER_DELETE;
            }
            when AFTER_UNDELETE {
                this.context = TriggerContext.AFTER_UNDELETE;
            }
        }
    }

    @testVisible
    private void setTriggerContextForTest(String ctx) {
        switch on ctx {
            when 'before insert' {
                context = TriggerContext.BEFORE_INSERT;
            }
            when 'before update' {
                context = TriggerContext.BEFORE_UPDATE;
            }
            when 'before delete' {
                context = TriggerContext.BEFORE_DELETE;
            }
            when 'after insert' {
                context = TriggerContext.AFTER_INSERT;
            }
            when 'after update' {
                context = TriggerContext.AFTER_UPDATE;
            }
            when 'after delete' {
                context = TriggerContext.AFTER_DELETE;
            }
            when 'after undelete' {
                context = TriggerContext.AFTER_UNDELETE;
            }
            when else {
                throw new TriggerHandler.TriggerHandlerException(
                    'Unexpected trigger context set'
                );
            }
        }
    }

    private void callCorrectHandlerMethod() {
        switch on this.context {
            when BEFORE_INSERT {
                this.beforeInsert();
            }
            when BEFORE_UPDATE {
                this.beforeUpdate();
            }
            when AFTER_INSERT {
                this.afterInsert();
            }
            when AFTER_UPDATE {
                this.afterUpdate();
            }
            when BEFORE_DELETE {
                this.beforeDelete();
            }
            when AFTER_DELETE {
                this.afterDelete();
            }
            when AFTER_UNDELETE {
                this.afterUndelete();
            }
        }
    }

    public static void bypass(String handlerName) {
        TriggerHandler.bypassedHandlers.add(handlerName);
    }
 
    public static void clearBypass(String handlerName) {
        TriggerHandler.bypassedHandlers.remove(handlerName);
    }

    public static Boolean isBypassed(String handlerName) {
        return TriggerHandler.bypassedHandlers.contains(handlerName);
    }

    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected virtual void beforeInsert() {
    }

    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected virtual void beforeUpdate() {
    }

    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected virtual void beforeDelete() {
    }

    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected virtual void afterInsert() {
    }

    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected virtual void afterUpdate() {
    }

    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected virtual void afterDelete() {
    }

    @SuppressWarnings('PMD.EmptyStatementBlock')
    protected virtual void afterUndelete() {
    }

    private enum TriggerContext {
        BEFORE_INSERT,
        BEFORE_UPDATE,
        BEFORE_DELETE,
        AFTER_INSERT,
        AFTER_UPDATE,
        AFTER_DELETE,
        AFTER_UNDELETE
    }
}
