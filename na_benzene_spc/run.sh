#!/bin/bash

#splits files into solute and solvent 

for i in *xyz2 ; do sed -n 3,14p $i  > ${i:0:2}a.f; done

for i in *xyz2 ; do sed -n 15p $i > ${i:0:2}b.f; done

for i in *xyz2; do sed -n 16,615p $i > ${i:0:2}c.f; done


for i in *a.f; do sed -n '1~12{N;N;p}' $i | sed 's/^.\{,5\}//' | awk -v n=3 '1; NR % n == 0 {print "fragment BENZENE"}' | sed '1 i\fragment BENZENE' | sed '$ d' > ${i:0:2}a.xyz; done
for i in *b.f; do sed -n '1{N;N;p}' $i | sed 's/^.\{,5\}//' | awk -v n=3 '1; NR % n == 0 {print "fragment NA"}' | sed '1 i\fragment NA' | sed '$ d' > ${i:0:2}b.xyz; done
for i in *c.f; do sed -n '1~3{N;N;p}' $i | sed 's/^.\{,5\}//'| awk -v n=3 '1; NR % n == 0 {print "fragment WATER"}' | sed '1 i\fragment WATER' | sed '$ d' > ${i:0:2}c.xyz; done

for i in *.xyz; do cat TITLE ${i:0:2}a.xyz ${i:0:2}b.xyz ${i:0:2}c.xyz > ${i:0:2}.inp; done

rm *.f;
rm *.xyz;
