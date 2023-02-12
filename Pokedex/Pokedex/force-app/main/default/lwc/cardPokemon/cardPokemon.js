import { LightningElement, api } from 'lwc';
import { NavigationMixin } from "lightning/navigation"; 


export default class CardPokemon extends NavigationMixin (LightningElement){
    
    @api poke;

    navigateToPokemon(event) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.target.name,
                objectApiName: 'Pokemon__c',
                actionName: 'view'
            }
        });
    }

}