import { LightningElement,api,wire } from 'lwc';
import getAccounts from'@salesforce/apex/SendTwiloSMS.messageAPI';
import { getRecord } from 'lightning/uiRecordApi';
const FIELDS = [
    'Account.Name',
    'Account.Phone'
];
export default class RichTextExample extends LightningElement {
    @api recordId;
    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    account;
    get Name() {
        return this.account.data.fields.Name.value;
    }

    get Phone() {
        return this.account.data.fields.Title.Phone;
    }
    myVal = '<strong>Enter your message to be sent.</strong>';
    handleChange(event) {
        this.myVal = event.target.value;
    }
    handleClick(event) {
        getAccounts({ ToMobile: this.account.data.fields.Phone.value,
                      AccountName:this.account.data.fields.Name.value,
                        Message: this.myVal })

		.then(result => {
			this.accounts = result;
			this.error = undefined;
		})
		.catch(error => {
			this.error = error;
			this.accounts = undefined;
		})
    }
}