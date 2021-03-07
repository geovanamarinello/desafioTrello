*** Settings ***
Documentation       Documentação Trello: https://developer.atlassian.com/cloud/trello/rest/api-group-actions/
...                 Documentação RequestsLibrary: http://marketsquare.github.io/robotframework-requests/doc/RequestsLibrary.html#Post%20Request
Resource            ./variables/tokens.robot
Resource            trello.robot

*** Test Cases ***
Autenticação no Trello
    Criar sessão Trello
    Solicitar os dados do meu usuário
    Conferir o status code    200
    Conferir o reason         OK
    Conferir se retorna usuario "geovanamarinello"

Criação de Card
    Criar um card
    Conferir o status code    200
    Conferir o reason         OK

Alteração do Card criado
    Alterar o nome do card "${ID_CARD}"
    Conferir o status code    200
    Conferir o reason         OK

Remoção do Card criado
    Arquivar o card "${ID_CARD}"
    Conferir o status code    200
    Conferir o reason         OK

    Remover o card "${ID_CARD}"
    Conferir o reason         OK
    Conferir o status code    200
