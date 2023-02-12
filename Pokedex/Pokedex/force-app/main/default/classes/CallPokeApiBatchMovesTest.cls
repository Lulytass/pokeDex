@IsTest
public class CallPokeApiBatchMovesTest {
	
    @isTest
    static void insertMovesSucessful(){
        
       	StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('geMovesResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        	CallPokeApiBatchMoves api = new CallPokeApiBatchMoves();
            Database.executeBatch(api, 826);
        Test.stopTest();
    	
        Movimiento__c query = [select Name, Tipo__c, power__c, Prioridad__c, Efecto__c from Movimiento__c];
        String nombre = (String) query.Name;
        String efecto = (String) query.Efecto__c;
        // Verify mock response is not null
        System.assertEquals(1, [select count() from Movimiento__c]);
        System.assertEquals('Pound',nombre);
        System.assertNotEquals('pound',nombre, 'Los nombres no coinciden, el nombre');
        System.assertEquals('Inflicts regular damage with no additional effect.',efecto);
        
    }
     
    @isTest
    static void noSeCreoElRegistro(){
       	StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('geMovesResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        	CallPokeApiBatchMoves api = new CallPokeApiBatchMoves();
            Database.executeBatch(api, 826);
        Test.stopTest();
    	
        // Verify mock response is not null
        System.assertNotEquals(1, [select count() from Habilidad__c],'La cantidad de movimientos no fue la esperada, fue :: '+ [select count() from Habilidad__c]);
    }

}