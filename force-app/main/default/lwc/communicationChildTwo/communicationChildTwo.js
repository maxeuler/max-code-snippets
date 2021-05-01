import { LightningElement } from 'lwc';
import pubsub from 'c/communicationPubSub';

export default class CommunicationChildTwo extends LightningElement {
    text = 'This will change';

    connectedCallback() {
        this.initSubscribtion();
    }

    subscriberCallback = eventText => {
        this.text = eventText;
    }

    initSubscribtion() {
        pubsub.subscribe('ontextchange', this.subscriberCallback);
    }

}