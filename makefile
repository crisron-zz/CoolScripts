# Compiler
CC = g++
# Flag required to create object files
CFLAGS = -c -std=c++11
# Contains executable EDF
TARGET = bin/
# Contains object files
OBJ = obj/
# Contains header files
INCLUDE = include/
# Contains source files
SRC = src/
# Contains input
IN = input
# Is generated and contains output
OUT = output

# Contains the names of all the source files
SOURCES=$(wildcard $(SRC)*.cpp)
# Contains the names of all the header files
HEADERS=$(wildcard $(INCLUDE)*.hpp)
# Contains the names of all the object files
OBJECTS=$(patsubst %.cpp,$(OBJ)%.o,$(notdir $(SOURCES)))

# notdir - Extracts all but the directory-part of each file name

# $(patsubst pattern,replacement,text)
# patsubst - Finds whitespace-separated words in text that match pattern and replaces them with replacement. Here pattern may contain a ‘%’ which acts as a wildcard, matching any number of any characters within a word. If replacement also contains a ‘%’, the ‘%’ is replaced by the text that matched the ‘%’ in pattern

# All : $(TARGET)EDF

# Main target --- output file
All : $(OUT)

# Rule to create output file
$(OUT) : $(TARGET)EDF $(IN)
	./$< < $(word 2,$^) > $@

# Rule to create executable file
$(TARGET)EDF : make_dir $(OBJECTS)
	$(CC) $(OBJECTS) -o $@ -lm

# $@ - The file name of the target of the rule

# $(OBJ)comparefuncs.o : $(SRC)comparefuncs.cpp $(HEADERS)
	# $(CC) $(CFLAGS) -I$(INCLUDE) $< -o $@

# $< - The name of the first prerequisite

# $(OBJ)EDF.o : $(SRC)EDF.cpp $(HEADERS)
	# $(CC) $(CFLAGS) -I$(INCLUDE) $< -o $@

# $(OBJ)input.o : $(SRC)input.cpp $(HEADERS)
	# $(CC) $(CFLAGS) -I$(INCLUDE) $< -o $@

# $(OBJ)main.o : $(SRC)main.cpp $(HEADERS)
	# $(CC) $(CFLAGS) -I$(INCLUDE) $< -o $@

# $(OBJ)print.o : $(SRC)print.cpp $(HEADERS)
	# $(CC) $(CFLAGS) -I$(INCLUDE) $< -o $@
	
# Rule to create object files
$(OBJ)%.o : $(SRC)%.cpp $(HEADERS)
	$(CC) $(CFLAGS) -I$(INCLUDE) $< -o $@

# Rule to create bin/ and obj/ directories
make_dir:
	mkdir -p obj bin
	
# Rule to clean the temporary, object, executable and output files and obj/ and bin/ directories
clean:
	-rm -rf bin
	-rm -rf obj
	-rm -f EDF *.o *~ output
