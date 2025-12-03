all:
	rm -rf build
	mkdir build
	gcc src/rm.c -o build/rm

debug:
	rm -rf build
	mkdir build
	gcc -g src/rm.c -o build/rm
