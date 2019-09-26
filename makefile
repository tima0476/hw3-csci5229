# makefile for hw3 - adapted from class example 10 makefile
EXE=hw3

# Main target
all: $(EXE)

#  MinGW
ifeq "$(OS)" "Windows_NT"
CFLG=-O3 -Wall
LIBS=-lglut32cu -lglu32 -lopengl32
CLEAN=del *.exe *.o *.a
else
#  OSX
ifeq "$(shell uname)" "Darwin"
CFLG=-O3 -Wall -Wno-deprecated-declarations
LIBS=-framework GLUT -framework OpenGL
#  Linux/Unix/Solaris
else
CFLG=-O3 -Wall
LIBS=-lglut -lGLU -lGL -lm
endif
#  OSX/Linux/Unix/Solaris
CLEAN=rm -f $(EXE) *.o *.a
endif

# Dependencies
hw3.o: hw3.c rocket.h hsv2rgb.h
hsv2rgb.o: hsv2rgb.c hsv2rgb.h

#  Create archive
hw3.a:hw3.o hsv2rgb.o
	ar -rcs $@ $^

# Compile rules
.c.o:
	gcc -c $(CFLG) $<
.cpp.o:
	g++ -c $(CFLG) $<

#  Link
hw3:hw3.o hw3.a
	gcc -O3 -o $@ $^   $(LIBS)
	./hw3

#  Clean
clean:
	$(CLEAN)