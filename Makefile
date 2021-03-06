default: output.txt

symboltorturever.c: gentorture.py
	python gentorture.py > symboltorturever.c

symboltorturever.o: symboltorturever.c
	gcc -fPIC -c -o symboltorturever.o symboltorturever.c

redefine-syms.sh: symboltorturever.o Makefile
	echo "objcopy \\" > redefine-syms.sh
	nm symboltorturever.o | awk '{ o=$$3; gsub(/SPACE/, "SP ACE", o); print "--redefine-sym=\"" $$3 "=" o "\" \\"; }' >> redefine-syms.sh
	echo "symboltorturever.o symboltorturever-space.o" >> redefine-syms.sh

symboltorturever-space.o: symboltorturever.o redefine-syms.sh
	sh redefine-syms.sh

libsymboltorturever.so: symboltorturever-space.o symboltorturever.map
	gcc -shared -Wl,--version-script=symboltorturever.map -o libsymboltorturever.so symboltorturever-space.o

output.txt: libsymboltorturever.so
	objdump -w -f -p -T -R libsymboltorturever.so > output.txt

output: output.txt
	cat output.txt

.PHONY: output
