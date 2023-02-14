@IsTest
public with sharing class CallPokeApiBatchAbilitiesTest {
    
    @isTest
    static void insertAbilitySucessful(){
       	StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getAbilityResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        	CallPokeApiBatchAbilities api = new CallPokeApiBatchAbilities();
            Database.executeBatch(api, 267);
        Test.stopTest();
    	
        // Verify mock response is not null
        System.assertEquals(1, [select count() from Habilidad__c],'sucessful');
        Habilidad__c query = [select Name, Efecto__c from Habilidad__c];
        
        System.assertEquals('Stench',query.Name);
        System.assertEquals('Has a 10% chance of making target Pok�mon flinch with each hit.',query.Efecto__c);
        
    }
         @isTest
    static void noSeEstableceLaConexion(){
       	StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('getAbilityResource');
        mock.setStatusCode(201);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);
        Test.startTest();
        	CallPokeApiBatchAbilities api = new CallPokeApiBatchAbilities();
            Database.executeBatch(api, 267);
        Test.stopTest();
    	
        // Verify mock response is not null
        System.assertEquals(0, [select count() from Habilidad__c],'No se pudo establecer la conexión para crear el registro');
    }
}