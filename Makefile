all:
	rm -rf build
	mkdir build
	gcc rm.c -o build/rm

debug:
	rm -rf build
	mkdir build
	gcc -g rm.c -o build/rm
