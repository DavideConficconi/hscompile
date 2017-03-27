HYPERSCAN = /home/kaa2nx/AP/hyperscan
MNRL = /home/kaa2nx/AP/MNRL/C++
BOOST = /opt/boost_1_57_0

IDIR = ./include
SRCDIR = ./src

CC = gcc
CXX = g++
AR = ar
LD = ld

CFLAGS = -I$(IDIR) -iquote $(HYPERSCAN)/src -iquote $(HYPERSCAN)/build --std=c99
CXXFLAGS = -I$(IDIR) -I$(BOOST)/include -iquote $(HYPERSCAN)/src -iquote $(HYPERSCAN)/build -I$(MNRL)/include -I$(MNRL)/lib/json11 -I$(MNRL)/lib/valijson/include -I$(MNRL)/lib/valijson/thirdparty/nlohmann-json-1.1.0 --std=c++11
LDFLAGS = 
STATICLIB = $(HYPERSCAN)/build/lib/libhs.a $(MNRL)/libmnrl.a

_DEPS = *.h
_OBJ_HSCOMPILE = hscompile.o hs_compile_mnrl.o 

ODIR = ./build

DEPS = $(patsubst %,$(IDIR)/%,$(_DEPS))
OBJ_HSCOMPILE = $(patsubst %,$(ODIR)/%,$(_OBJ_HSCOMPILE))

all: hscompile

hscompile: $(OBJ_HSCOMPILE)
	$(CXX) -v $(LDFLAGS) $^ $(STATICLIB) -o $@ 

$(ODIR)/%.o: $(SRCDIR)/%.cpp $(DEPS)
	@pwd
	@mkdir -p $(ODIR)
	$(CXX) $(CXXFLAGS) -c -o $@ $<

$(ODIR)/%.o: $(SRCDIR)/%.c $(DEPS)
	@pwd
	@mkdir -p $(ODIR)
	$(CC) $(CFLAGS) -c -o $@ $<
	
.PHONY: clean

clean:
	rm -f $(ODIR)/*.o
	rmdir $(ODIR)