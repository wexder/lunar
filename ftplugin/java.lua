local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
  return
end

-- Determine OS
local home = os.getenv "HOME"
local launcher_path = vim.fn.glob(
  home .. "/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
)
if #launcher_path == 0 then
  launcher_path = vim.fn.glob(
    home .. "/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar",
    1,
    1
  )[1]
end
if vim.fn.has "mac" == 1 then
  WORKSPACE_PATH = home .. "/workspace/"
  CONFIG = "mac"
elseif vim.fn.has "unix" == 1 then
  WORKSPACE_PATH = home .. "/workspace/"
  CONFIG = "linux"
else
  print "Unsupported system"
end

-- Find root of project
local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" then
  return
end

local extendedClientCapabilities = jdtls.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = WORKSPACE_PATH .. project_name

-- NOTE: for debugging
-- git clone git@github.com:microsoft/java-debug.git ~/.config/lvim/.java-debug
-- cd ~/.config/lvim/.java-debug/
-- ./mvnw clean install
local bundles = vim.fn.glob(
  home .. "/development/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar"
)
-- if #bundles == 0 then
--   bundles = vim.fn.glob(
--     home .. "/development/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar",
--     1,
--     1
--   )
-- end

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. home .. "/.local/share/nvim/lsp_servers/jdtls/lombok.jar",
    "-Xms4g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    launcher_path,
    "-configuration",
    home .. "/.local/share/nvim/lsp_servers/jdtls/config_" .. CONFIG,
    "-data",
    workspace_dir,
  },
  on_attach = function (client, bufnr)
    jdtls.setup_dap {}
    jdtls.setup.add_commands()
    require("lvim.lsp").common_on_attach(client, bufnr)
  end,
  on_init = require("lvim.lsp").common_on_init,
  on_exit = require("lvim.lsp").common_on_exit,
  capabilities = require("lvim.lsp").common_capabilities(),
  root_dir = root_dir,
  settings = {
    java = {
      jdt = {
        ls = {
          vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx4G -Xms200m"
        }
      },
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      format = {
        enabled = true,
        comments = {
          enabled = false,
        },
        settings = {
          profile = "Steller",
          url = home .. "/.config/lvim/steller.xml",
        },
      },
    },
    signatureHelp = { enabled = true },
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
    },
    contentProvider = { preferred = "fernflower" },
    extendedClientCapabilities = extendedClientCapabilities,
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      useBlocks = true,
    },
  },
  flags = {
    allow_incremental_sync = true,
    server_side_fuzzy_completion = true,
  },
  init_options = {
    bundles = bundles,
  },
}

-- config["on_attach"] = function (client, bufnr)
--     require("lvim.lsp").common_on_attach(client, bufnr)
--     require('jdtls').setup_dap {}
-- end

jdtls.start_or_attach(config)
