public class pokemonsController {
	@AuraEnabled(cacheable=true)
	public static List<Pokemon__c> getPokemons(String tipo, String generacion, String name) {
        try{
            string condicion = '';
        	string query;
            Integer genInt;
            if(String.isNotBlank(generacion)){
                genInt = Integer.valueOf(generacion);
            }
            
        	if(String.isNotBlank(name)){
            	condicion = 'Name LIKE \'%' + name + '%\'';   
            }
        
        	if( String.isNotBlank(generacion) && String.isNotBlank(condicion) ){
            	condicion += ' AND Generacion__c = ' + genInt ;
        	}else if( String.isNotBlank(generacion) ){
            	condicion += ' Generacion__c = ' + genInt ;
            }
        
        	if( String.isNotBlank(tipo) && String.isNotBlank(condicion) ){
            	condicion += ' AND  Tipos__c INCLUDES (\'' + tipo +'\')';
            }else if(String.isNotBlank(tipo)){
                condicion += ' Tipos__c INCLUDES (\'' + tipo +'\')';
            }
        
        	if( String.isNotBlank(condicion) ){
            	query = 'SELECT Generacion__c,Imagen__c,Name,ExtId__c,Tipos__c FROM Pokemon__c WHERE ' + condicion + 'ORDER BY ExtId__c';
        	}else{
            	query = 'SELECT Generacion__c,Imagen__c,Name,ExtId__c,Tipos__c FROM Pokemon__c ORDER BY EXTId__c';
        	}
        	List<Pokemon__c> respuestaQuery = Database.query(query);
        
        	return respuestaQuery;
        }catch (Exception e) {
            throw new AuraException('Ocurrio un error al realizar la consulta:: ' + e.getMessage());    
        }
        
	}
    
   
}