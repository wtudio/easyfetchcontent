#include <filesystem>
#include <fstream>

extern "C" {
#include "lauxlib.h"
#include "lua.h"
#include "lualib.h"
}

using namespace std;

extern "C" int LuaPrint(lua_State* L) {
  const char* s = lua_tostring(L, 1);
  printf("%s", s);
  return 0;
}

extern "C" int LuaFoo(lua_State* L) {
  int n = lua_gettop(L);  // argc
  lua_Number sum = 0.0;

  int i;
  for (i = 1; i <= n; i++) {
    if (!lua_isnumber(L, i)) {
      lua_pushliteral(L, "invalid argument");
      lua_error(L);
    }
    sum += lua_tonumber(L, i);
  }
  lua_pushnumber(L, n);    // first return val
  lua_pushnumber(L, sum);  // second return val
  return 2;                // return  num
}

int32_t main(int32_t argc, char** argv) {
  lua_State* L = luaL_newstate();
  luaL_openlibs(L);

  lua_register(L, "print", LuaPrint);
  lua_register(L, "foo", LuaFoo);

  const std::filesystem::path& script_file = std::filesystem::absolute("./test.lua");

  std::ofstream ofile(script_file, std::ios::trunc);
  ofile << R"str(
-- testlib
print("test test !!!\n")

local n, sum = foo(1, 2, 3, 4, 5, 6, 7, 8, 9, 10)

print("n:" .. n .. ", sum:" .. sum .. "\n")

function testluafun(a, b)
    return (a .. b)
end
)str";
  ofile.close();

  int ret = luaL_dofile(L, script_file.string().c_str());
  if (ret) printf("load lua script ret:%d, msg:%s\n", ret, lua_tostring(L, -1));

  lua_getglobal(L, "testluafun");
  lua_pushstring(L, "aaa");
  lua_pushstring(L, "bbb");
  lua_pcall(L, 2, 1, 0);

  std::string lua_ret = lua_tostring(L, -1);
  printf("testluafun ret:%s\n", lua_ret.c_str());

  lua_close(L);

  return 0;
}
