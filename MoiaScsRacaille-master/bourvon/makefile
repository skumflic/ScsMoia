#JAVAC= javac -d . -cp /usr/local/sicstus4.4.1/bin/sp-4.4.1/sicstus-4.4.1/bin/jasper.jar 
JAVAC= javac -d . -cp /usr/local/sicstus4.4.1/lib/sicstus-4.4.1/bin/jasper.jar

#JAVAC= javac -d . -cp /applis/sicstus-4.3.3/lib/sicstus-4.3.3/bin/jasper.jar

sources = $(wildcard *.java)
classes = $(sources:.java=.class)

all: $(classes)

clean :
	rm -f *.class

%.class : %.java
	$(JAVAC) *.java
