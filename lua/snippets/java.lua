-- LuaSnip snippets for Java / Spring Boot
-- Loaded automatically by LuaSnip's lazy_load if you call
--   require("luasnip.loaders.from_lua").lazy_load({ paths = { vim.fn.stdpath("config") .. "/lua/snippets" } })
-- inside your cmp or luasnip plugin config.

local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- sout → System.out.println(...)
  s("sout", fmt("System.out.println({});", { i(1, "\"message\"") })),

  -- psvm → public static void main
  s(
    "psvm",
    fmt(
      [[public static void main(String[] args) {{
    {}
}}]],
      { i(1) }
    )
  ),

  -- getmap → @GetMapping method
  s(
    "getmap",
    fmt(
      [[@GetMapping("{}")
public ResponseEntity<{}> {}() {{
    return ResponseEntity.ok({});
}}]],
      { i(1, "/path"), i(2, "Object"), i(3, "methodName"), i(4, "null") }
    )
  ),

  -- postmap → @PostMapping method
  s(
    "postmap",
    fmt(
      [[@PostMapping("{}")
public ResponseEntity<{}> {}(@RequestBody {} {}) {{
    return ResponseEntity.ok({});
}}]],
      { i(1, "/path"), i(2, "Object"), i(3, "methodName"), i(4, "Object"), i(5, "body"), i(6, "null") }
    )
  ),

  -- autowired → @Autowired private field
  s(
    "autowired",
    fmt(
      "@Autowired\nprivate {} {};",
      { i(1, "MyService"), i(2, "myService") }
    )
  ),

  -- logger → SLF4J logger declaration
  s(
    "logger",
    fmt(
      'private static final org.slf4j.Logger log = org.slf4j.LoggerFactory.getLogger({}.class);',
      { i(1, "ClassName") }
    )
  ),

  -- opt → Optional.ofNullable chain
  s(
    "opt",
    fmt(
      "Optional.ofNullable({}).orElseThrow(() -> new RuntimeException(\"{}\"));",
      { i(1, "value"), i(2, "Not found") }
    )
  ),

  -- tryCatch → try/catch block
  s(
    "tc",
    fmt(
      [[try {{
    {}
}} catch ({} e) {{
    log.error("Error: {{}}", e.getMessage());
}}]],
      { i(1), i(2, "Exception") }
    )
  ),
}
