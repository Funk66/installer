lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.builtin.which_key.mappings.b.b = { "<cmd>buffer #<CR>", "Previous buffer" }
lvim.builtin.which_key.mappings.Q = { "<cmd>qa<CR>", "Quit all" }
lvim.builtin.which_key.mappings.g.t = {
  "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<CR>",
  "Toggle line blame"
}

lvim.builtin.bufferline.options.show_buffer_close_icons = false
lvim.builtin.alpha.active = false
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true

lvim.builtin.mason.ui.border = "rounded"

lvim.lsp.installer.setup.ui = { border = "rounded" }
lvim.lsp.float.border = "rounded"

lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
  return server ~= "jedi_language_server"
end, lvim.lsp.automatic_configuration.skipped_servers)


require("lvim.lsp.null-ls.formatters").setup {
  { command = "black",
    filetypes = { "python" },
    extra_args = function(params)
      return params.bufname:match("kialo") and { "-l 120" } or { "-l 80" }
    end,
  },
  { command = "isort", filetypes = { "python" } },
}

require("lvim.lsp.null-ls.linters").setup {
  { command = "flake8",
    filetypes = { "python" },
    extra_args = function(params)
      return {
        "--format",
        "default",
        "--config",
        params.bufname:match("kialo") and os.getenv("KIALO_ROOT") .. "/backend/.flake8" or ".flake8",
        "--stdin-display-name",
        "$FILENAME",
        "-",
      }
    end,
  },
}

-- TODO: merge dicts
require("lvim.lsp.manager").setup("yamlls", {
  settings = {
    yaml = {
      hover = true,
      completion = true,
      validate = true,
      schemaStore = {
        enable = true,
        url = "https://www.schemastore.org/api/json/catalog.json",
      },
      schemas = {
        kubernetes = {
          "daemon.{yml,yaml}",
          "manager.{yml,yaml}",
          "restapi.{yml,yaml}",
          "role.{yml,yaml}",
          "role_binding.{yml,yaml}",
          "*onfigma*.{yml,yaml}",
          "*ngres*.{yml,yaml}",
          "*ecre*.{yml,yaml}",
          "*eployment*.{yml,yaml}",
          "*ervic*.{yml,yaml}",
          "kubectl-edit*.yaml",
          "manifests/**/*yaml",
        },
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*.{yml,yaml}",
        ["https://json.schemastore.org/pre-commit-config.json"] = "/.pre-commit-config.yaml",
        ["https://json.schemastore.org/kustomization.json"] = "*/kustomization.yaml",
      },
    },
  },
})
