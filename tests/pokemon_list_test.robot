*** Settings ***
Library    RequestsLibrary    #  pip install robotframework-requests

*** Variables ***
${URL_POKEMONAPI}    https://pokeapi.co/api/v2/ 
${POKEMON_ENDPOINT}    pokemon?

*** Test Cases ***
Should return list
    [tags]    pokemonlist

    #DADO
    ${POKEMON}=    Set Variable    limit=100000&offset=0
    
    #E
    Create Session    list    ${URL_POKEMONAPI}

    #ENTAO
    ${response}=    GET On Session    list    ${POKEMON_ENDPOINT}${POKEMON}   expected_status=200
    Log To Console    ${response}
    Should Not Be Empty    ${response.json()}
    Should Be Equal    bulbasaur    ${response.json()["results"][0]["name"]}

Should return pokemonlist_2
    [tags]    pokemonlist2
    
    ${URL}    Dado que acesso o Pokemon Api    ${URL_POKEMONAPI}    ${POKEMON_ENDPOINT}
    ${RESPONSE}    E realizo a requisicao    ${URL}
    Então me retorna uma lista de Pokemons    ${RESPONSE}

*** Keywords ***
Dado que acesso o Pokemon Api 
    [Arguments]    ${URL_POKEMONAPI}    ${POKEMON_ENDPOINT}
    ${POKEMON}    Set Variable     limit=100000&offset=0
    ${URL}  Set Variable  ${URL_POKEMONAPI}${POKEMON_ENDPOINT}${POKEMON}

    [Return]    ${URL}
    

E realizo a requisicao
    [Arguments]    ${URL}
    Create Session    list    ${URL}
    ${RESPONSE}=    GET On Session    list    ${URL}   expected_status=200   

    [Return]    ${RESPONSE}  

Então me retorna uma lista de Pokemons 
    [Arguments]    ${RESPONSE}
    Log To Console    ${response}
    Should Not Be Empty    ${response.json()}
    Should Be Equal    bulbasaur    ${response.json()["results"][0]["name"]}

