return {

  -- ============================================================
  -- MASON - Tool Installer
  -- ============================================================
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- Lua / Shell
        "luacheck",
        "shellcheck",
        "shfmt",

        -- Web
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "html-lsp",
        "emmet-ls",
        "prettierd",
        "eslint-lsp",

        -- Python (switched to basedpyright)
        "basedpyright",
        "ruff",
        "debugpy",

        -- Rust
        "rust-analyzer",
        "codelldb",
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

      -- Stop ALL LSPs from re-running diagnostics on every keystroke
      diagnostics = {
        update_in_insert = false,
        virtual_text = { spacing = 4 },
      },

      on_attach = function(_, _)
        vim.api.nvim_set_hl(0, "LspReferenceText", { underline = true })
        vim.api.nvim_set_hl(0, "LspReferenceRead", { underline = true })
        vim.api.nvim_set_hl(0, "LspReferenceWrite", { underline = true, bold = true })
      end,

      ---@type lspconfig.options
      servers = {

        -- ── HTML ────────────────────────────────────────────────
        html = {
          filetypes = { "html", "htmldjango", "jinja" },
        },

        -- ── Emmet (HTML/CSS expansion) ──────────────────────────
        emmet_ls = {
          filetypes = {
            "html",
            "css",
            "scss",
            "sass",
            "javascriptreact",
            "typescriptreact",
            "htmldjango",
          },
          on_attach = function(client, _)
            client.server_capabilities.completionProvider.triggerCharacters = {}
          end,
        },

        -- ── CSS ─────────────────────────────────────────────────
        cssls = {
          settings = {
            css = { validate = true, lint = { unknownAtRules = "ignore" } },
            scss = { validate = true },
            less = { validate = true },
          },
        },

        -- ── Tailwind CSS ────────────────────────────────────────
        tailwindcss = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          settings = {
            tailwindCSS = {
              experimental = { classRegex = { "tw`([^`]*)", "tw\\('([^']*)'\\)" } },
            },
          },
        },

        -- ── TypeScript / JavaScript ─────────────────────────────
        tsserver = {
          root_dir = function(...)
            return require("lspconfig.util").root_pattern(".git")(...)
          end,
          single_file_support = false,
          -- Cap memory so it doesn't eat your RAM on large projects
          init_options = {
            maxTsServerMemory = 512,
          },
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "literal",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },

        -- ── ESLint ───────────────────────────────────────────────
        eslint = {
          settings = {
            workingDirectory = { mode = "auto" },
            format = { enable = true },
            lint = { enable = true },
          },
          on_attach = function(_, bufnr)
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "EslintFixAll",
            })
          end,
        },

        -- ── Python (basedpyright - faster drop-in for pyright) ──
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "standard",
                -- Only check open files, not the entire workspace
                diagnosticMode = "openFilesOnly",
                -- Don't crawl into library internals (FastAPI/SQLAlchemy stubs are huge)
                useLibraryCodeForTypes = false,
                autoSearchPaths = true,
              },
            },
          },
        },

        -- ── Lua ─────────────────────────────────────────────────
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
                  ["ambiguity"] = "Opened",
                  ["await"] = "Opened",
                  ["codestyle"] = "None",
                  ["duplicate"] = "Opened",
                  ["global"] = "Opened",
                  ["luadoc"] = "Opened",
                  ["redefined"] = "Opened",
                  ["strict"] = "Opened",
                  ["strong"] = "Opened",
                  ["type-check"] = "Opened",
                  ["unbalanced"] = "Opened",
                  ["unused"] = "Opened",
                },
                unusedLocalExclude = { "_*" },
              },
              format = {
                enable = false,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
          },
        },
      },
      setup = {},
    },
  },

  -- ============================================================
  -- TREESITTER - Syntax Highlighting & Parsing
  -- ============================================================
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- Web
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",
        "jsonc",
        "scss",
        "graphql",
        "http",
        "handlebars",
        "glimmer",
        "astro",
        -- Python
        "python",
        -- Rust
        "rust",
        "toml",
        -- Lua / Shell / Misc
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
  -- FORMATTING - Conform
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
        -- Lua / Shell
        lua = { "stylua" },
        sh = { "shfmt" },
        fish = { "fish_indent" },
        -- Python
        python = { "isort", "black" },
        -- C/C++
        c = { "clang_format" },
        cpp = { "clang_format" },
        -- Rust
        rust = { "rustfmt" },
        -- Web
        html = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        scss = { "prettierd", "prettier" },
        less = { "prettierd", "prettier" },
        javascript = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        jsonc = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
      },
    },
  },

  -- ============================================================
  -- AUTO-TAG - Auto close & rename HTML/JSX tags
  -- ============================================================
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      autotag = {
        enable = true,
        filetypes = {
          "html",
          "xml",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
        },
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
        options = {
          remember_venv_auto_activate = true, -- auto re-activates last venv
        },
        search = {
          venv = { patterns = { "venv", ".venv", "env", ".env" } },
          poetry = { enabled = true },
          conda = { enabled = true },
        },
        picker = {
          name = "snacks",
        },
      },
    },
    keys = {
      { "<leader>cv", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
    },
  },

  -- ============================================================
  -- CMP - Completion Sources
  -- ============================================================
  -- {
  --   "nvim-cmp",
  --   dependencies = {
  --     "hrsh7th/cmp-emoji",
  --   },
  --   opts = function(_, opts)
  --     table.insert(opts.sources, { name = "emoji" })
  --   end,
  -- },
}
