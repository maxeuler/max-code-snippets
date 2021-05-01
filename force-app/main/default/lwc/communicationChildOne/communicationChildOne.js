import { LightningElement } from 'lwc';
import pubsub from 'c/communicationPubSub';

export default class CommunicationChildOne extends LightningElement {
    textValue = '';

    handleTextChange(event) {
        this.textValue = event.target.value;
    }

    handleButtonClick() {
        this.publishEvent(this.textValue);
    }

    publishEvent(dataToPublish) {
        pubsub.publish('ontextchange', dataToPublish);
    }
}