return {

  -- ============================================================
  -- MASON
  -- ============================================================
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "luacheck",
        "shellcheck",
        "shfmt",
        "emmet-ls",
        "basedpyright",
        "ruff",
        "debugpy",
        "rust-analyzer",
        "codelldb",
        -- extras handle: tailwindcss-language-server, typescript-language-server,
        -- css-lsp, html-lsp, prettierd, eslint-lsp
      })
    end,
  },

  -- ============================================================
  -- LSP CONFIG
  -- ============================================================
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      diagnostics = {
        update_in_insert = false,
        virtual_text = { spacing = 4 },
      },
      on_attach = function(_, _)
        vim.api.nvim_set_hl(0, "LspReferenceText", { underline = true })
        vim.api.nvim_set_hl(0, "LspReferenceRead", { underline = true })
        vim.api.nvim_set_hl(0, "LspReferenceWrite", { underline = true, bold = true })
      end,
      servers = {

        html = {
          filetypes = { "html", "htmldjango", "jinja" },
        },

        emmet_ls = {
          filetypes = { "html", "css", "scss", "sass", "javascriptreact", "typescriptreact", "htmldjango" },
          on_attach = function(client, _)
            client.server_capabilities.completionProvider.triggerCharacters = {}
          end,
        },

        cssls = {
          settings = {
            css = { validate = true, lint = { unknownAtRules = "ignore" } },
            scss = { validate = true },
            less = { validate = true },
          },
        },

        -- Keep only your custom classRegex override, the rest is handled by the extra
        tailwindcss = {
          settings = {
            tailwindCSS = {
              experimental = { classRegex = { "tw`([^`]*)", "tw\\('([^']*)'\\)" } },
            },
          },
        },

        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "standard",
                diagnosticMode = "openFilesOnly",
                useLibraryCodeForTypes = false,
                autoSearchPaths = true,
              },
            },
          },
        },

        lua_ls = {
          single_file_support = true,
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              completion = { workspaceWord = true, callSnippet = "Both" },
              misc = { parameters = {} },
              hint = {
                enable = true,
                setType = false,
                paramType = true,
                paramName = "Disable",
                semicolon = "Disable",
                arrayIndex = "Disable",
              },
              doc = { privateName = { "^_" } },
              type = { castNumberToInteger = true },
              diagnostics = {
                disable = { "incomplete-signature-doc", "trailing-space" },
                groupSeverity = { strong = "Warning", strict = "Warning" },
                groupFileStatus = {
                  ambiguity = "Opened",
                  await = "Opened",
                  codestyle = "None",
                  duplicate = "Opened",
                  global = "Opened",
                  luadoc = "Opened",
                  redefined = "Opened",
                  strict = "Opened",
                  strong = "Opened",
                  ["type-check"] = "Opened",
                  unbalanced = "Opened",
                  unused = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = { indent_style = "space", indent_size = "2", continuation_indent_size = "2" },
              },
            },
          },
        },
      },
      setup = {},
    },
  },

  -- ============================================================
  -- TREESITTER
  -- ============================================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- extras handle: javascript, typescript, tsx, json, jsonc
        "html",
        "css",
        "scss",
        "graphql",
        "http",
        "handlebars",
        "astro",
        "python",
        "rust",
        "toml",
        "lua",
        "bash",
        "vim",
        "sql",
        "gitignore",
      })
      opts.query_linter = {
        enable = true,
        use_virtual_text = true,
        lint_events = { "BufWrite", "CursorHold" },
      }
    end,
  },

  -- ============================================================
  -- FORMATTING
  -- ============================================================
  {
    "stevearc/conform.nvim",
    dependencies = { "mason.nvim" },
    lazy = true,
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>cF",
        function()
          require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
        end,
        mode = { "n", "x" },
        desc = "Format Injected Langs",
      },
    },
    opts = {
      default_format_opts = {
        timeout_ms = 3000,
        async = false,
        quiet = false,
        lsp_format = "fallback",
      },
      formatters_by_ft = {
        -- prettier extra handles all web filetypes
        lua = { "stylua" },
        sh = { "shfmt" },
        fish = { "fish_indent" },
        python = { "isort", "black" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        rust = { "rustfmt" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
      },
    },
  },

  -- ============================================================
  -- AUTO-TAG
  -- ============================================================
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      autotag = {
        enable = true,
        filetypes = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact" },
      },
    },
  },

  -- ============================================================
  -- PYTHON - Virtual Env Selector
  -- ============================================================
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    cmd = "VenvSelect",
    opts = {
      settings = {
        options = { remember_venv_auto_activate = true },
        search = {
          venv = { patterns = { "venv", ".venv", "env", ".env" } },
          poetry = { enabled = true },
          conda = { enabled = true },
        },
        picker = { name = "snacks" },
      },
    },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
  },
}
