-- Java file template generator with class type selection
-- Automatically creates class skeleton with multiple type options

local class_types = {
  class = {
    name = "public class",
    template = function(pkg, class)
      return {
        "package " .. pkg .. ";",
        "",
        "public class " .. class .. " {",
        "",
        "    public " .. class .. "() {",
        "    }",
        "",
        "}",
      }
    end,
  },
  abstract = {
    name = "public abstract class",
    template = function(pkg, class)
      return {
        "package " .. pkg .. ";",
        "",
        "public abstract class " .. class .. " {",
        "",
        "}",
      }
    end,
  },
  interface = {
    name = "public interface",
    template = function(pkg, class)
      return {
        "package " .. pkg .. ";",
        "",
        "public interface " .. class .. " {",
        "",
        "}",
      }
    end,
  },
  enum = {
    name = "public enum",
    template = function(pkg, class)
      return {
        "package " .. pkg .. ";",
        "",
        "public enum " .. class .. " {",
        "    ;",
        "",
        "    " .. class .. "() {}",
        "}",
      }
    end,
  },
  record = {
    name = "public record",
    template = function(pkg, class)
      return {
        "package " .. pkg .. ";",
        "",
        "public record " .. class .. "() {",
        "",
        "}",
      }
    end,
  },
  annotation = {
    name = "@interface (Annotation)",
    template = function(pkg, class)
      return {
        "package " .. pkg .. ";",
        "",
        "public @interface " .. class .. " {",
        "",
        "}",
      }
    end,
  },
  service = {
    name = "@Service (Spring)",
    template = function(pkg, class)
      return {
        "package " .. pkg .. ";",
        "",
        "import org.springframework.stereotype.Service;",
        "",
        "@Service",
        "public class " .. class .. " {",
        "",
        "    public " .. class .. "() {",
        "    }",
        "",
        "}",
      }
    end,
  },
  repository = {
    name = "@Repository (Spring)",
    template = function(pkg, class)
      return {
        "package " .. pkg .. ";",
        "",
        "import org.springframework.stereotype.Repository;",
        "",
        "@Repository",
        "public interface " .. class .. " {",
        "",
        "}",
      }
    end,
  },
  controller = {
    name = "@RestController (Spring)",
    template = function(pkg, class)
      return {
        "package " .. pkg .. ";",
        "",
        "import org.springframework.web.bind.annotation.RequestMapping;",
        "import org.springframework.web.bind.annotation.RestController;",
        "",
        "@RestController",
        '@RequestMapping("/")',
        "public class " .. class .. " {",
        "",
        "}",
      }
    end,
  },
}

local function extract_package_and_class(file_path)
  local pkg = file_path:match("src/main/java/(.+)/[^/]+%.java$")
  if not pkg then
    pkg = file_path:match("src/test/java/(.+)/[^/]+%.java$")
  end
  if not pkg then
    pkg = file_path:match(".+/([^/]+)/[^/]+%.java$") or "com.example"
  end
  if pkg then
    pkg = pkg:gsub("/", ".")
  end

  local class = file_path:match("([^/]+)%.java$")
  if class then
    class = class:gsub("%.java$", "")
  end

  return pkg, class
end

local function apply_template(type_key)
  if not type_key or type_key == "" then
    type_key = "class"
  end

  if not class_types[type_key] then
    vim.notify("Invalid class type: " .. type_key, vim.log.levels.ERROR)
    return
  end

  local file_path = vim.fn.expand("%:p")
  local pkg, class = extract_package_and_class(file_path)

  if not pkg or not class then
    vim.notify("Could not extract package or class name", vim.log.levels.ERROR)
    return
  end

  local template = class_types[type_key].template(pkg, class)
  vim.api.nvim_buf_set_lines(0, 0, -1, false, template)
  vim.notify("Created " .. class_types[type_key].name .. ": " .. class, vim.log.levels.INFO)

  -- Posiciona cursor na última linha útil e entra em insert mode
  local last_line = #template - 1
  vim.api.nvim_win_set_cursor(0, { last_line, 4 })
  vim.cmd("startinsert")
end

local function show_menu(pkg, class)
  local choices = {}
  for key, ct in pairs(class_types) do
    table.insert(choices, { key = key, name = ct.name })
  end

  table.sort(choices, function(a, b)
    return a.name < b.name
  end)

  vim.ui.select(choices, {
    prompt = "Select Java class type for " .. class .. ": ",
    format_item = function(item)
      return item.name
    end,
  }, function(choice)
    if choice then
      apply_template(choice.key)
    else
      apply_template("class")
    end
  end)
end

local function create_java_template()
  if vim.b.java_template_created then
    return
  end

  local file_path = vim.fn.expand("%:p")

  if not file_path:match("%.java$") then
    return
  end

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  for _, line in ipairs(lines) do
    if line:match("[^%s]") then
      return
    end
  end

  local pkg, class = extract_package_and_class(file_path)

  if not class or class == "" then
    return
  end

  vim.b.java_template_created = true
  show_menu(pkg, class)
end

vim.api.nvim_create_user_command("JavaTemplate", function(opts)
  apply_template(opts.args)
end, {
  nargs = "?",
  complete = function()
    return { "class", "abstract", "interface", "enum", "record", "annotation", "service", "repository", "controller" }
  end,
  desc = "Generate Java class template (class|abstract|interface|enum|record|annotation|service|repository|controller)",
})

local java_template_group = vim.api.nvim_create_augroup("JavaTemplate", { clear = true })

vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  pattern = "*.java",
  callback = function()
    vim.schedule(function()
      create_java_template()
    end)
  end,
  group = java_template_group,
})
