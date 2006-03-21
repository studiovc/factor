CC = gcc
CP = cp

BINARY = f
IMAGE = factor.image
BUNDLE = Factor.app
BUNDLE_BINARY = $(BUNDLE)/Contents/MacOS/Factor
BUNDLE_IMAGE = $(BUNDLE)/Contents/Resources/factor.image

ifdef DEBUG
	DEFAULT_CFLAGS = -g
	STRIP = touch
else
	DEFAULT_CFLAGS = -Wall -O3 -ffast-math -fomit-frame-pointer $(SITE_CFLAGS)
	STRIP = strip
endif

DEFAULT_LIBS = -lm

ifdef NO_UI
	UNIX_UI_LIBS =
else
	UNIX_UI_LIBS = -lfreetype -lGL -lGLU -lX11
endif

WIN32_OBJS = native/win32/ffi.o \
	native/win32/file.o \
	native/win32/misc.o \
	native/win32/run.o \
	native/win32/memory.o

UNIX_OBJS = native/unix/file.o \
	native/unix/signal.o \
	native/unix/ffi.o \
	native/unix/memory.o \
	native/unix/icache.o

MACOSX_OBJS = $(UNIX_OBJS) \
	native/macosx/run.o \
	native/macosx/mach_signal.o

GENERIC_UNIX_OBJS = $(UNIX_OBJS) \
	native/unix/run.o

ifdef WIN32
 	PLAF_OBJS = $(WIN32_OBJS)
 	PLAF_SUFFIX = .exe
else
	ifdef MACOSX
		PLAF_OBJS = $(MACOSX_OBJS)
	else
		PLAF_OBJS = $(GENERIC_UNIX_OBJS)
	endif
endif

OBJS = $(PLAF_OBJS) native/array.o native/bignum.o \
	native/s48_bignum.o \
	native/complex.o native/cons.o native/error.o \
	native/factor.o native/fixnum.o \
	native/float.o native/gc.o \
	native/image.o native/memory.o \
	native/misc.o native/primitives.o \
	native/ratio.o native/relocate.o \
	native/run.o \
	native/sbuf.o native/stack.o \
	native/string.o native/cards.o native/vector.o \
	native/word.o native/compiler.o \
	native/alien.o native/dll.o \
	native/boolean.o \
	native/debug.o \
	native/hashtable.o \
	native/io.o \
	native/wrapper.o \
	native/ffi_test.o

default:
	@echo "Run 'make' with one of the following parameters:"
	@echo ""
	@echo "bsd"
	@echo "linux"
	@echo "linux-ppc"
	@echo "macosx"
	@echo "solaris"
	@echo "windows"
	@echo ""
	@echo "Also, you might want to set the SITE_CFLAGS environment"
	@echo "variable to enable some CPU-specific optimizations; this"
	@echo "can make a huge difference. Eg:"
	@echo ""
	@echo "export SITE_CFLAGS=\"-march=pentium4 -ffast-math\""

bsd:
	$(MAKE) $(BINARY) \
		CFLAGS="$(DEFAULT_CFLAGS) -export-dynamic -pthread" \
		LIBS="$(DEFAULT_LIBS) $(UI_LIBS)" 
	$(STRIP) $(BINARY)

macosx:
	$(MAKE) $(BINARY) \
		CFLAGS="$(DEFAULT_CFLAGS)" \
		LIBS="$(DEFAULT_LIBS) -framework Cocoa -framework OpenGL -lfreetype" \
		MACOSX=y

macosx.app:
	$(CP) $(BINARY) $(BUNDLE_BINARY)
	$(CP) $(IMAGE) $(BUNDLE_IMAGE)

linux linux-x86 linux-amd64:
	$(MAKE) $(BINARY) \
		CFLAGS="$(DEFAULT_CFLAGS) -export-dynamic" \
		LIBS="-ldl $(DEFAULT_LIBS) $(UNIX_UI_LIBS)"
	$(STRIP) $(BINARY)

linux-ppc:
	$(MAKE) $(BINARY) \
		CFLAGS="$(DEFAULT_CFLAGS) -export-dynamic -mregnames" \
		LIBS="-ldl $(DEFAULT_LIBS) $(UNIX_UI_LIBS)"
	$(STRIP) $(BINARY)

solaris solaris-x86:
	$(MAKE) $(BINARY) \
		CFLAGS="$(DEFAULT_CFLAGS) -D_STDC_C99 -Drestrict=\"\" " \
		LIBS="-ldl -lsocket -lnsl $(DEFAULT_LIBS) -R/opt/PM/lib -R/opt/csw/lib -R/usr/local/lib -R/usr/sfw/lib -R/usr/X11R6/lib -R/opt/sfw/lib $(UNIX_UI_LIBS)"
	$(STRIP) $(BINARY)

windows:
	$(MAKE) $(BINARY) \
		CFLAGS="$(DEFAULT_CFLAGS) -DWIN32" \
		LIBS="$(DEFAULT_LIBS)" WIN32=y

f: $(OBJS)
	$(CC) $(LIBS) $(CFLAGS) -o $@$(PLAF_SUFFIX) $(OBJS)

clean:
	rm -f $(OBJS)

.c.o:
	$(CC) -c $(CFLAGS) -o $@ $<

.S.o:
	$(CC) -c $(CFLAGS) -o $@ $<

.m.o:
	$(CC) -c $(CFLAGS) -o $@ $<

boot:
	echo "USE: image \"$(ARCH)\" make-image bye" | ./f factor.image
	./f boot.image.$(ARCH) $(BOOTSTRAP_FLAGS)
	
