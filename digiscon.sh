#!/bin/bash
#__str4vinsk__


function install()
{
	echo "Installing..."
        mkdir /usr/share/digiscon
        cp -r resources/ src/ duck2spark.py encoder.jar /usr/share/digiscon/
        chmod 777 digiscon.sh
        cp digiscon.sh /usr/bin/digiscon
	echo "Done!"
	exit
}

if [ "$EUID" -ne 0 ];then
	echo "[!!] Run digiscon as root! [!!]"
  	exit
fi


if [ "$1" == "install" ]; then
	if [[ -e "/usr/share/digiscon" ]]; then
                echo "Digiscon is already installed!"
		read -p "Do you want to reinstall it (y/n) ? " yn
		if [[ "$yn" = "y" ]]; then
			rm -rf /usr/share/digiscon
                	install
		elif [ "$yn" = "n" ]; then
			echo "Okay"
			exit
		else
			echo "[!!] Invalid!"
			exit
		fi
        else
		install
	fi
fi


if [ "$#" -ne 1 ]; then
	echo "[!!] ERROR [!!]"
        echo "Please use: ./digiscon script.duck"
	echo "To install it: ./digiscon.sh install"
else
	if [ -e "$1" ]; then
		if [[ "$1" =~ ".duck" ]]; then
			file_name="$(echo $1 | cut -d '.' -f1)"
 			echo "[!!] Converting from duck script to a binary file..."
			if [ -e "/usr/share/digiscon" ]; then
				java -jar /usr/share/digiscon/encoder.jar -i $1 -o $file_name.bin -l /usr/share/digiscon/resources/br.properties
				python2 /usr/share/digiscon/duck2spark.py -i $file_name.bin -o $file_name.ino
			else
				java -jar encoder.jar -i $1 -o $file_name.bin -l resources/br.properties
				python2 duck2spark.py -i $file_name.bin -o $file_name.ino
			fi
			echo "[!!] Successfully generated binary file!"
			echo "[!!] Your INO script is ready to be used! Good luck."
		else
			echo "Please choose a valid duck script file!"
		fi
	else
		echo "[!!] ERROR [!!]"
		echo "File - $1 - not found"
	fi
fi

