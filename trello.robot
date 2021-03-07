*** Settings ***
Documentation       Documentação Trello: https://developer.atlassian.com/cloud/trello/rest/api-group-actions/
...                 Documentação RequestsLibrary: http://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html#Post%20Request
Library             RequestsLibrary
Library             Collections
Resource            ./variables/tokens.robot

*** Keywords ***
### SETUP E TEARDOWN ----------------------------------------------------------
Criar sessão Trello
    ${AUTH}         Create List     ${MY_TRELLO_KEY}       ${MY_TRELLO_TOKEN}
    Create Session  alias=mytrello  url=${TRELLO_HOST}     auth=${AUTH}

Solicitar os dados do meu usuário
    ${PARAMS}       Create Dictionary    key=${MY_TRELLO_KEY}   token=${MY_TRELLO_TOKEN}
    ${RESPOSTA}     Get Request          alias=mytrello         uri=1/members/me   params=${PARAMS}

    Set Test Variable   ${RESPOSTA}

### AÇÕES ----------------------------------------------------------
Criar um card
    ${HEADERS}    Create Dictionary    content-type=application/json
    ${PARAMS}     Create Dictionary    key=${MY_TRELLO_KEY}   token=${MY_TRELLO_TOKEN}   idList=${MY_ID_LIST}
    ${RESPOSTA}   Post Request         mytrello      1/cards    params=${PARAMS}
    ...                                 data={"desc": "O primeiro card foi criado", "name": "PRIMEIRO CARD CRIADO"}
    ...                                 headers=${HEADERS}

    ${ID_CARD}   Get Variable Value    ${RESPOSTA.json()["id"]}
    Set Global Variable  ${ID_CARD}
    Set Test Variable    ${RESPOSTA}

Alterar o nome do card "${ID_CARD}"
    ${HEADERS}    Create Dictionary    content-type=application/json
    ${PARAMS}     Create Dictionary    key=${MY_TRELLO_KEY}         token=${MY_TRELLO_TOKEN}
    ${RESPOSTA}   PUT Request          mytrello      1/cards/${ID_CARD}      params=${PARAMS}
    ...                                 data={"desc": "O nome do card foi alterado", "name": "MEU CARD ALTERADO"}
    ...                                 headers=${HEADERS}

    Set Test Variable     ${RESPOSTA}

Arquivar o card "${ID_CARD}"
    ${HEADERS}    Create Dictionary    content-type=application/json
    ${PARAMS}     Create Dictionary    key=${MY_TRELLO_KEY}         token=${MY_TRELLO_TOKEN}    closed=true

    ${RESPOSTA}   PUT Request          mytrello      1/cards/${ID_CARD}      params=${PARAMS}
    Set Test Variable     ${RESPOSTA}

Remover o card "${ID_CARD}"
    ${HEADERS}    Create Dictionary    content-type=application/json
    ${PARAMS}     Create Dictionary    key=${MY_TRELLO_KEY}         token=${MY_TRELLO_TOKEN}

    ${RESPOSTA}   Delete Request     mytrello      1/cards/${ID_CARD}       params=${PARAMS}
    Set Test Variable     ${RESPOSTA}

### CONFERENCIAS ----------------------------------------------------------
Conferir o status code
    [Arguments]   ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings    ${RESPOSTA.status_code}    ${STATUSCODE_DESEJADO}

Conferir o reason
    [Arguments]   ${REASON_DESEJADO}
    Should Be Equal    ${RESPOSTA.reason}    ${REASON_DESEJADO}

Conferir se retorna usuario "${USER}"
    Should Be Equal    ${RESPOSTA.json()["username"]}    ${USER}
