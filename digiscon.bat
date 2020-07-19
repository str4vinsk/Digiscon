@echo off
@chcp 65001

set ext=%~x1
set nome=%~n1

IF EXIST "%1" (

	IF "%ext%" == ".txt" (
		ECHO [!!] Converting from duck script to a binary file...
		java -jar encoder.jar -i "%1" -o "%nome%".bin -l resources/br.properties
		python2 duck2spark.py -i "%nome%".bin -o "%nome%".ino
	) ELSE (
		ECHO [!!] Please, select a valid ".txt" file [!!]
	)

) ELSE ( 
	ECHO [!!] File - "%1" - not found [!!]
  	ECHO Please, select a valid ".txt" file.	
)

