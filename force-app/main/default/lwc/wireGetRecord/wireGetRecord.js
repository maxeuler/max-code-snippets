import { LightningElement, wire, api } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import OWNER_NAME_FIELD from '@salesforce/schema/Account.Owner.Name';
import WEBSITE_FIELD from '@salesforce/schema/Account.Website';

export default class WireGetRecord extends LightningElement {
    @api recordId;
    account = {};
    @wire(getRecord, { recordId: '$recordId', fields: [
        NAME_FIELD,
        OWNER_NAME_FIELD,
        WEBSITE_FIELD
    ]})
    wiredAccount({ data, error }) {
        if (data) this.processServerData(data);
        if (error) handleWireError(error);
    }

    processServerData({ fields }) {
        Object.keys(fields).forEach(item => {
            let value = fields[item] && fields[item].displayValue
                ? fields[item].displayValue
                : fields[item].value;
            //this.account[item] = value;
            this.account = { ...this.account, [item]: value };
        });
    }

    handleWireError(error) {
        // TODO
        console.error(error);
    }
}