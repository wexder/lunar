local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = '/home/wexder/development/java/workspaces/' .. project_name
local config = {
  cmd = {
    '/usr/lib/jvm/java-11-openjdk/bin/java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xms1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-javaagent:/home/wexder/.local/share/nvim/lsp_servers/jdtls/lombok.jar',
    '-jar', '/home/wexder/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    '-configuration', '/home/wexder/.local/share/nvim/lsp_servers/jdtls/config_linux',
    '-data', workspace_dir
  },
  root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
  settings = {
    java = {
        format = {
                enabled = true,
                settings = {
                        profile= "Steller",
                        url= "/home/wexder/development/java/steller.xml"
                        }
                },

    }
  },
  init_options = {
    bundles = {
      vim.fn.glob("/home/wexder/development/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
    }
  },
}

config['on_attach'] = function(client, bufnr)
  require('jdtls').setup_dap()
end

require('jdtls').start_or_attach(config)


