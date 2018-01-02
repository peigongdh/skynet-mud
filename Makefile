include platform.mk

LUA_CLIB_PATH ?= server/luaclib

LUA_CLIB = webclient

CFLAGS = -g -O2 -Wall -I$(LUA_INC) $(MYCFLAGS)

# lua
LUA_STATICLIB := skynet/3rd/lua/liblua.a
LUA_LIB ?= $(LUA_STATICLIB)
LUA_INC ?= skynet/3rd/lua

all : \
    $(foreach v, $(LUA_CLIB), $(LUA_CLIB_PATH)/$(v).so)

$(LUA_CLIB_PATH)/webclient.so : server/lualib-src/webclient.c | $(LUA_CLIB_PATH)
	$(CC) $(CFLAGS) $(SHARED) -Iserver/lualib-src/webclient $^ -o $@ -lcurl
