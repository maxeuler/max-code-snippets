import { LightningElement } from 'lwc';

export default class CustomModalContainer extends LightningElement {
    showModal = false;

    // modal props
    title = 'My Custom Title';
    showHeader = false
    headerText = 'yes';
    body = 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.'
    showButton = false;
    buttonTitle = 'Cool';
    showSecondButton = false;
    secondButtonTitle = 'Cancel';
    
    handleShowModal() {
        this.showModal = true;
    }

    handleClose() {
        this.showModal = false;
    }

    handleToggleChange(event) {
        this[event.target.name] = event.target.checked;
    }

    handleTextInputChange(event) {
        this[event.target.name] = event.target.value;
    }

    handleButtonClick() {
        this.handleClose();
    }
}