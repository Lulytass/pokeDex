@IsTest
public class CallPokeApiBatchTest {
	@isTest
    static void insertMovesSucessful(){
       	StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getPokemonsResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        	CallPokeApiBatch api = new CallPokeApiBatch();
            Database.executeBatch(api, 898);
        Test.stopTest();
    	
        // Verify mock response is not null
        System.assertEquals(1, [select count() from Pokemon__c],'sucessful');
    }
     
    @isTest
    static void noSeEstableceLaConexion(){
       	StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getPokemonsResource');
        mock.setStatusCode(400);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        	CallPokeApiBatch api = new CallPokeApiBatch();
            Database.executeBatch(api, 898);
        Test.stopTest();
    	
        // Verify mock response is not null
        System.assertEquals(0, [select count() from Pokemon__c],'No se creo el registro');
    }

}