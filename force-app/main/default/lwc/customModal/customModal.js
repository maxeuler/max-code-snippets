import { LightningElement, api } from 'lwc';

export default class LightningModul extends LightningElement {
    @api title = 'My Title';
    @api showHeader = false
    @api headerText = '';
    @api body = ''
    @api showButton = false;
    @api buttonTitle = 'Save';
    @api showSecondButton = false;
    @api secondButtonTitle = 'Cancel';
    
    get showFooter() {
        return this.showButton || this.showSecondButton;
    }

    get headerClass() {
        return this.showHeader 
            ? 'slds-modal__header' 
            : 'slds-modal__header slds-modal__header_empty';
    }

    closeHandler() {
        this.dispatchEvent(new CustomEvent('close'));
    }

    handleButtonClick() {
        this.dispatchEvent(new CustomEvent('buttonclicked'));
    }
}