#!/bin/bash


for i in *.xyz ; do sed -n 3,218p $i  > coro.gro; done

sed -n '1~36{N;N;p}' coro.gro | sed 's/^.\{,5\}//' | awk -v n=3 '1; NR % n == 0 {print "fragment CORO"}' | sed '1 i\fragment CORO' | sed '$ d' > coro.inp;

for i in *.xyz ; do sed -n 219,5418p $i > hexane.gro; done

sed 's/^.\{,5\}//' hexane.gro > mod_hexane.gro; 

split -l 20 mod_hexane.gro; 

for i in x*; 
	do sed -n '1,4p'   $i > $i.a; 
	   sed -n '5,7p'   $i > $i.b; 
	   sed -n '8,10p'  $i > $i.c; 
	   sed -n '11,13p' $i > $i.d; 
	   sed -n '14,16p' $i > $i.e; 
	   sed -n '17,20p' $i > $i.f; 
	   cat a_1 $i.a a_2 $i.b a_3 $i.c a_4 $i.d a_5 $i.e a_6 $i.f > $i.inp; 
	done

rm *.a; rm *.b; rm *.c; rm *.d; rm *.e; rm *.f; 

for i in x*.inp; 
	do cat $i >> hexane.inp; 
	done 


cat TITLE coro.inp hexane.inp > coro_hexane.inp; 
