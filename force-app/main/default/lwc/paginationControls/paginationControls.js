import { LightningElement, api } from 'lwc';

export default class PaginationControls extends LightningElement {
    currentPage = 1;
    allRecods;
    recordsOnCurrentPage;
    pageCount;
    pageSize = 1;

    get records() {
        return this.recordsOnCurrentPage;
    }

    @api
    set records(data) {
        if (data) {
            console.log('##  ' + data);
            this.allRecods = data;
            this.pageCount = Math.ceil(data.length / this.pageSize);
            this.passCurrentRecordsToParent();
        }
    }

    passCurrentRecordsToParent() {
        const start = (this.currentPage - 1) * this.pageSize;
        const end = this.pageSize * this.currentPage;
        this.recordsOnCurrentPage = this.allRecods.slice(start, end);
        console.log(this.recordsOnCurrentPage);
        this.dispatchEvent(new CustomEvent('passcurrentrecords', {
            detail: {
                records: this.recordsOnCurrentPage
            }
        }));
    }

    get isPreviousButtonDisables() {
        return this.currentPage <= 1;
    }

    get isNextButtonDisables() {
        return this.currentPage >= this.pageCount;
    }

    handlePreviousClick() {
        if (this.currentPage > 1) {
            this.currentPage -= 1;
            this.passCurrentRecordsToParent();
        }
    }

    handleNextClick() {
        if (this.currentPage < this.pageCount) {
            this.currentPage += 1;
            this.passCurrentRecordsToParent();
        }
    }
}