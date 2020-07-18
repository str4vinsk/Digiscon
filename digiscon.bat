@echo off
@chcp 65001

set ext=%~x1

IF EXIST "%1" (

	IF "%ext%" == ".txt" (
		set nome=%~n1
		java -jar encoder.jar -i "%1" -o "%nome%".bin -l resources/br.properties
		python2 duck2spark.py -i "%nome%".bin -o "%nome%".ino
	) ELSE (
		ECHO O arquivo não é um txt!
	)

) ELSE ( 
	ECHO [!!] O arquivo indicado não existe! [!!]
  	ECHO Por favor, selecione um arquivo ".txt" válido.	
)

