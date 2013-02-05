#!/bin/bash

#menu
function menu {
	echo
	echo Co chcesz zrobic?
	echo 1 Znalezc haslo
	echo 2 Dodac wpis
	echo 3 Wyjsc
	echo
	echo Podaj liczbe:
	read corobic

	while [ $corobic != 1 ] && [ $corobic != 2 ] && [ $corobic != 3 ]
	do
		echo
		echo Nie rozumiem.
		echo
		echo Co chcesz zrobic? 
		echo 1 Znalezc haslo
		echo 2 Dodac wpis
		echo 3 Wyjsc
		echo
		echo Podaj liczbe:
		read corobic
	done;

	if [ $corobic = 1 ]
	then
		ZnalezcHaslo
	fi

	if [ $corobic = 2 ]
	then
		echo Jakie haslo chcesz dodac?
		read haslo
		CzyIstnieje $haslo
	fi
}

#czy istnieje
function CzyIstnieje {
	
	cat slownik.txt | grep -i -w ^$1 > spr.txt #sprawdza wzorzec z pliku
	wc -m spr.txt | cut -d ' ' -f 1 > wynik.txt #sprawdza ile znakow
	wynik=`cat "wynik.txt"`
	
	if [ $wynik != 0 ] #co gdy haslo juz istnieje
	then
		echo Takie haslo juz istnieje.
		echo "Czy chcesz dopisac kolejny opis do tego hasla?"
		echo
		echo 1 Tak
		echo 2 Nie
		echo
		echo Podaj liczbe:
		read codalej
							#co robic dalej - pisac czy nie 
		while [ $codalej != 1 ] && [ $codalej != 2 ] #TU COS NIE GRA!!!
		do
			echo 
			echo Nie rozumiem.
			echo
			echo "Czy chcesz dopisac kolejny opis do tego hasla?"
			echo
			echo 1 Tak
			echo 2 Nie
			echo
			echo Podaj liczbe:
			read codalej
		done

		if [ $codalej = 1 ]
		then 
			DodacWpis $1
		fi

		if [ $codalej = 2 ]
		then
			menu
		fi

	fi

	#rm spr.txt #usuwanie smieci
	#rm spr2.txt
	#rm wynik.txt

	DodacWpis $1
}

#znalezc haslo
function ZnalezcHaslo {
	echo 
	echo Jakiego hasla szukasz?
	read haslo
	echo

	
	cat slownik.txt | grep -i -w ^$haslo

	echo
	echo Wcisnij Enter
	read

	#rm spr.txt #usuwanie smieci

	menu
}

#dadac wpis
function DodacWpis {

	echo
	echo Podaj opis hasla
	read opis

	echo $1 - $opis >> slownik.txt
	sort slownik.txt > slownik1.txt
	rm slownik.txt
	mv slownik1.txt slownik.txt

	menu
}

menu


