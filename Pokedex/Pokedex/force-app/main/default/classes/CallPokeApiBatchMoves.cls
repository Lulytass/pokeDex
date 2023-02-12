public class CallPokeApiBatchMoves implements Database.Batchable<Integer>, Database.AllowsCallouts{
    public List<Integer> start(Database.BatchableContext bt){
        //agregamos en la lista los numeros que usaremos para las llamadas a la API
        List<Integer> ind = new List<Integer>();
        for(integer i=1; i<=826;i++){//		826
            ind.add(i);
        }
        return ind;
    }
    
    Integer j = 0;
    public void execute(Database.BatchableContext bc, List<Integer> scope){
        //llamado a la Api
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/move/'+scope[j]);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Accept', 'application/json');
        HttpResponse response = http.send(request);
      	//evaluamos el estatus de la llamada
      
        if (response.getStatusCode() == 200) {
            
            //usamos parse con clase apex para acceder a los datos simples y deserializeUntype para las listas
            MovesPokeApiJson pokeApiMov = MovesPokeApiJson.parse(response.getBody());
            
            Map <String, Object> pokemonesMap = (Map <String, Object>) JSON.deserializeUntyped(response.getBody());
            
            //mapas, listas y strings para acceder al efecto
            Map <String, Object> pokemonefectosMap = new Map <String, Object>();
            Map <String, Object> pokeefectoMap = new Map <String, Object>();
            List <Object> efectosList = (List<Object>) pokemonesMap.get('effect_entries');
            List <Object> efectoList = new List<Object>();
            String efectoString = '';
            String efectosString = '';
            
            //evaluamos que la lista no este vacia y accedemos a los move
            if(!efectosList.isEmpty()){
                for(Object efecto : efectosList){
                    pokemonefectosMap = (Map<String, Object>) efecto;
                    efectoList.add(pokemonefectosMap.get('language'));      
                }
            }
            //evaluamos que la lista no este vacia y tenga move para poder acceder a name y poner la
             
            if(!efectoList.isEmpty()){
                for(Object t : efectoList){
                    pokeefectoMap = (Map <String, Object>) t;
                    if(pokeefectoMap.get('name') == 'en'){
                        efectoString = (String) pokemonefectosMap.get('short_effect');
                    
                    }
                    
                }
            }
            
            
            Movimiento__c movimiento = new Movimiento__c(
            	ExtId__c = pokeApiMov.id,
            	Name = pokeApiMov.name.capitalize(),
                Chance_de_Efecto__c = pokeApiMov.effect_chance,
                Efecto__c = efectoString,
                power__c = pokeApiMov.power,
                Pp__c = pokeApiMov.pp,
                Prioridad__c = pokeApiMov.priority,
                Punteria__c = pokeApiMov.accuracy,
                Tipo__c = pokeApiMov.type.name,
                Objetivo__c = pokeApiMov.target.name    
        	);
        	try {
            // insertamos el registro creado
            	insert movimiento;         
        	} catch(Exception e) {
            	System.debug('Error al insertar registro:: ' + e);
        	}
        	j++;
        } 
        else{
             	System.debug('Codigo de error al conectar a la api::'+ response.getStatusCode());
            }   
    }
    public void finish(Database.BatchableContext bc){
        //operacion que ejecutamos al finalizar el execute
        system.debug('termino el batch');
    }
}