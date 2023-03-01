
*** Settings ***
Library    RequestsLibrary   # pip install robotframework-requests

*** Variables ***
${URL_POKEMONAPI}        https://pokeapi.co/api/v2/
${POKEMON_ENDPOINT}      pokemon/


*** Test Cases ***
Should return Pikachu
    [tags]    pokemon

    #DADO
    ${pokemon}=    Set variable    pikachu
    
    #QUANDO
    Create Session    abc    ${URL_POKEMONAPI}

    #ENTÂO
    ${response}=    GET On Session    abc    ${POKEMON_ENDPOINT}${pokemon}   expected_status=200
    Log To Console    ${response}

    Should Not Be Empty    ${response.json()}
    Should Be Equal    pikachu    ${response.json()["forms"][0]["name"]}
    
Should return Pikachu_2
    [tags]    pokemon2

    ${url}    Dado que acesso o Pokemon Api    ${URL_POKEMONAPI}    ${POKEMON_ENDPOINT}
    ${response}    E realizo a requisicao    ${url}
    Então me retorna os recursos do pokemon    ${response}


Scenario outline test
    [Template]    Scenario outline: test examples

    #Examples
    #endpoint    name         alias    
    pikachu      pikachu      test     
    bulbasaur    bulbasaur    test2    
    meowth       meowth       test3    

*** Keywords ***

Scenario outline: test examples
    [Arguments]    ${endpoint}    ${name}    ${alias}    

    ${url}    Dado que acesso o Pokemon Api     ${URL_POKEMONAPI}    ${POKEMON_ENDPOINT}    ${endpoint} 
    ${response}    E realizo a requisicao    ${url}    ${alias}
    Então me retorna os recursos do pokemon    ${response}    ${name}   


Dado que acesso o Pokemon Api 
    [Arguments]    ${URL_POKEMONAPI}    ${POKEMON_ENDPOINT}    ${endpoint}=pikachu
    
    ${url}  Set Variable  ${URL_POKEMONAPI}${POKEMON_ENDPOINT}${endpoint}
    Log To Console    ${endpoint}

    [Return]    ${url}
    

E realizo a requisicao
    [Arguments]    ${URL}    ${alias}=default

    Create Session    ${alias}    ${URL}
    ${response}=    GET On Session    ${alias}    ${URL}   
    Log To Console    ${alias}

    [Return]    ${response}  


Então me retorna os recursos do pokemon
    [Arguments]    ${response}    ${name}=pikachu   

    Log To Console    ${name}
    Status Should Be    200    ${response}
    Should Not Be Empty    ${response.json()}
    Should Be Equal    ${name}    ${response.json()["forms"][0]["name"]}

    


    

    

