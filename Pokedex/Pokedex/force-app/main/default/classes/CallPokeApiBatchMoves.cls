public class CallPokeApiBatchMoves implements Database.Batchable<Integer>, Database.AllowsCallouts{
    public List<Integer> start(Database.BatchableContext bt){
        //agregamos en la lista los numeros que usaremos para las llamadas a la API
        List<Integer> ind = new List<Integer>();
        for(integer i=1; i<=826;i++){//		826
            ind.add(i);
        }
        return ind;
    }
    
    public void execute(Database.BatchableContext bc, List<Integer> scope){
        //llamado a la Api
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/move/'+scope[0]);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Accept', 'application/json');
        HttpResponse response = http.send(request);
      	//evaluamos el estatus de la llamada
      
        if (response.getStatusCode() == 200) {
            
            //usamos parse con clase apex para acceder a los datos simples y deserializeUntype para las listas
            //MovesPokeApiJson pokeApiMov = MovesPokeApiJson.parse(response.getBody());
            
            Map <String, Object> pokemonesMap = (Map <String, Object>) JSON.deserializeUntyped(response.getBody());
            
            //mapas, listas y strings para acceder al efecto
            List <Object> pokeefectoList = (List<Object>) pokemonesMap.get('effect_entries');
            Map <String, Object> pokeefectoMap = new Map <String, Object>();
            List <Object> efectoList = new List<Object>();
            String efectoString = '';
            //Map <String, Object> pokeefectoMap =(Map<String, Object>) pokemonesMap.get('effect_entries');
            
            if(!pokeefectoList.isEmpty()){
                for(Object efecto : pokeefectoList){
                    pokeefectoMap = (Map<String, Object>) efecto;
                    efectoList.add(pokeefectoMap.get('short_effect'));      
                }
                efectoString = (String) efectoList[0];
            }
            


            
            String nameMov =(String) pokemonesMap.get('name');
            
            //type name
            Map<String, Object> type =(Map<String, Object>) pokemonesMap.get('type');
            string nameType =(String) type.get('name');
            
            //target name
            Map<String, Object> target =(Map<String, Object>) pokemonesMap.get('target');
            string nameTarget =(String) target.get('name');
            
            Movimiento__c movimiento = new Movimiento__c(
            	ExtId__c = (integer) pokemonesMap.get('id'),							//pokeApiMov.id,
            	Name = nameMov.capitalize(),											//pokeApiMov.name.capitalize(),
                Chance_de_Efecto__c = (integer) pokemonesMap.get('effect_chance'),		//pokeApiMov.effect_chance,
                Efecto__c = efectoString,
                power__c = (integer) pokemonesMap.get('power'),							//pokeApiMov.power,
                Pp__c = (integer) pokemonesMap.get('pp'),								//pokeApiMov.pp,
                Prioridad__c = (integer) pokemonesMap.get('priority'),					//pokeApiMov.priority,
                Punteria__c = (integer) pokemonesMap.get('accuracy'),					//pokeApiMov.accuracy,
                Tipo__c = nameType,														//pokeApiMov.type.name,
                Objetivo__c = nameTarget												//pokeApiMov.target.name    
        	);
        	try {
            // insertamos el registro creado
            	insert movimiento;         
        	} catch(Exception e) {
            	System.debug('Error al insertar registro:: ' + e);
        	}
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