import { LightningElement } from 'lwc';

export default class Pagination extends LightningElement {
    sampleList = [
        'Max',
        'Moritz',
        'Peter'
    ];
    currentRecords;

    handleNewPage(event) {
        this.currentRecords = [...event.detail.records];
        console.log('### ' + this.currentName);
    }

}