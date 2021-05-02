# max-code-snippets

## Table of Contents
1. [APEX](#apex)
1. [LWC](#LWC)
   1. [navigation](#navigation)
   1. [communication](#communication)


## APEX

### CollectionUtils
A class with multiple methods to work with collections. Used to create maps with a specific key. This key can be an ID field or a string.

`idMapFromCollectionByKey`

`stringMapFromCollectionByKey`

`mapFromCollectionWithCollectionValues`

## LWC

### navigation
- buttons on a lwc to navigate to different places in SF or create records with default values


### communication
- pubSub model: lwc `communicationPubSub`
- bubble events:
  ```js
    // publisher
    handleClick() {
        let event = new CustomEvent('message', {
            detail: {
                value: 'message'
            },
            bubbles: true
        });
        this.dispatchEvent(event);
    }

    // subsriber
    connectedCallback() {
        window.addEventListener(
            'message', 
            this.handleMessageEvent, 
            false
        );
    }

    handleMessageEvent = event => {
        let detail = event.detail.value;
        alert(`${detail} has been received`);
    }

    disconnectedCallback() {
        window.removeEventListener(
            'message', 
            this.handleMessageEvent, 
            false
        );
    }
  ```