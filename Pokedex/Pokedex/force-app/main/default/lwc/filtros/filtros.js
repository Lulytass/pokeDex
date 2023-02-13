import { LightningElement, wire } from 'lwc';
import generateData from '@salesforce/apex/pokemonsController.getPokemons';
//import contador from '@salesforce/apex/pokemonsController.cantidadDePokemonesListados';
import { getPicklistValues } from "lightning/uiObjectInfoApi";
import Tipos_c from "@salesforce/schema/Pokemon__c.Tipos__c";

export default class Filtros extends LightningElement {

    //variables pasadas a generateData
    tipo = "";
    generacion = null;
    name = "";
    
    pokeData;
    visiblepokes;
    error;

    //variables pasadas a contador
    //tiposFilt = "";
    //generacionFilt = null;
    //nameFilt = "";
    cantidad;
    cantText;

    TiposPickList;
    doneTypingInterval = 1000;

    //inicio del acordeon con la pestaña A activa
    handleSetActiveSectionC() {
        const accordion = this.template.querySelector('.example-accordion');

        accordion.activeSectionName = 'A';
    }

    //capturamos los valores de la picklist y agregamos el valor Todos
    @wire(getPicklistValues, {
        recordTypeId: "012000000000000AAA",
        fieldApiName: Tipos_c
    })statusPickLists({ data , error}) {
        if (data) {
            this.TiposPickList = [
                { label: "Todos", value: null },
                ...data.values
            ];
        } else if (error){
            console.error("error", error);
        } 
    }
    //le damos valores al combo box
    get comboBoxGen() {
        return [
            { label: 'Todos', value: null },
            { label: 'Generación 1', value: '1' },
            { label: 'Generación 2', value: '2' },
            { label: 'Generación 3', value: '3' },
            { label: 'Generación 4', value: '4' },
            { label: 'Generación 5', value: '5' },
            { label: 'Generación 6', value: '6' },
            { label: 'Generación 7', value: '7' }
        ];
    }
    //evento en la pestaña b del acordeon para tomar el valor elegido y se lo pasamos a las variables que 
    //le pasamos a las funciones generateData y contador
    handleGeneracionChange(event){
        this.generacion =  event.detail.value;              //this.generacionFilt =
    }
    //evento en la pestaña c del acordeon para tomar los valores elegidos, pasamos el array a string y reemplazamos la
    //, que agrega toString entre los valores por el ; y asignamos dicho valor a las variables que pasamos
    // a las funciones generateData y contador
    handleTipoChange(event) {
        let resultados = event.detail.value;
        let resultadosComoString = resultados.toString();
        let resultado = resultadosComoString.replace(",",";");
        this.tipo  = resultado;                                 //= this.tiposFilt
    }
    //evento en la pestaña a que toma lo ingresado y asignamos dicho valor a las variables que pasamos
    // a las funciones generateData y contador, setTimeout para dar tiempo al usuario de ingresar el valor antes de 
    //actualizar las variables
    handleKeyUp(event) {
        clearTimeout(this.typingTimer);
        let value = event.target.value;
        this.typingTimer = setTimeout(() => {
            this.name =  value;                                 //this.nameFilt =
        }, this.doneTypingInterval);
    }
    //llamamos a nuestra funcion apex con el decorador wire y guardamos lo que retorna en una variable
    //pasamos nuestras variables como parametros
    @wire(generateData, {
        tipo: "$tipo",
        generacion: "$generacion",
        name: "$name"
    })wiredPokemones({data,error}){
        if (data) {
            this.pokeData = data;
            this.cantidad = Object.keys(data).length;
            this.cantText = '';
            if(this.cantidad == false){
                this.cantText = 'No se han encontrado Pokemons';
            }
        } else if (error) {
            this.error = error;
            console.log(error);
        }
    }
    

    //actualizamos la lista con los pokemos que se muestran
    updatePokeHandler(event){
        this.visiblepokes=[...event.detail.records]
    }
    
}