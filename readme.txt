A construção do desafio foi feito em robot framework.

Para executar, seguir as seguintes instruções
1-Ter instalado python 3 (https://www.python.org/downloads/)
2-Ter instalado o robot framework e suas bbibliotecas via comando:	
	pip install robotframework
	pip install --upgrade robotframework-seleniumlibrary
	pip install -U robotframework-requests
3-O arquivo tokens.robot deve estar dentro da pasta variables ou deve ser alterado no trello.robot
4-Para executar, basta abrir a pasta que o arquivo está e executar 
	robot -d \results testCase.robot
5-Já está em anexo os logs da executação dos testes em documentos que o robot fornece 
