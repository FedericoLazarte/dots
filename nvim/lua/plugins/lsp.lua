return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    config = function()
      -- Diagnósticos
      vim.diagnostic.config({
        virtual_text = true,
        severity_sort = true,
        float = {
          style = "minimal",
          border = "rounded",
          source = "if_many",
          header = "",
          prefix = "",
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN]  = "▲",
            [vim.diagnostic.severity.HINT]  = "⚑",
            [vim.diagnostic.severity.INFO]  = "»",
          },
        },
      })

      -- ---------------------------------------------------------------
      -- Configuración por servidor
      -- (capabilities se omiten: Neovim aplica los defaults de 0.11,
      --  y si usas blink.cmp/nvim-cmp, inyéctalas aparte)
      -- ---------------------------------------------------------------

      -- Lua
      vim.lsp.config("lua_ls", {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })

      -- JavaScript / TypeScript
      vim.lsp.config("ts_ls", {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = {
          "javascript",
          "javascriptreact",
          "javascript.jsx",
          "typescript",
          "typescriptreact",
          "typescript.tsx",
        },
        root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
        settings = {
          completions = { completeFunctionCalls = true },
        },
      })

      -- HTML
      vim.lsp.config("html", {
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html" },
        root_markers = { "package.json", ".git" },
      })

      -- CSS
      vim.lsp.config("cssls", {
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss", "less" },
        root_markers = { "package.json", ".git" },
        settings = {
          css  = { validate = true },
          scss = { validate = true },
          less = { validate = true },
        },
      })

      -- Go
      vim.lsp.config("gopls", {
        cmd = { "gopls" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        root_markers = { "go.mod", "go.work", ".git" },
        settings = {
          gopls = {
            analyses = {
              unusedparams = false,
              ST1003 = false,
              ST1000 = false,
            },
            staticcheck = true,
          },
        },
      })

      -- Python
      vim.lsp.config("pyright", {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
      })

      -- Emmet (ampliado a JSX/TSX y CSS)
      vim.lsp.config("emmet_language_server", {
        cmd = { "emmet-language-server", "--stdio" },
        filetypes = {
          "html",
          "css",
          "scss",
          "less",
          "javascriptreact",
          "typescriptreact",
        },
        root_markers = { ".git" },
        init_options = {
          showExpandedAbbreviation = "always",
          showAbbreviationSuggestions = true,
        },
      })

      -- ---------------------------------------------------------------
      -- Keymaps al adjuntar el LSP
      -- ---------------------------------------------------------------
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my.lsp.attach", { clear = true }),
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local buf = args.buf

          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
          end

          map("n", "K",   vim.lsp.buf.hover,           "Hover")
          map("n", "gd",  vim.lsp.buf.definition,      "Definition")
          map("n", "gD",  vim.lsp.buf.declaration,     "Declaration")
          map("n", "gi",  vim.lsp.buf.implementation,  "Implementation")
          map("n", "go",  vim.lsp.buf.type_definition, "Type definition")
          map("n", "gr",  vim.lsp.buf.references,      "References")
          map("n", "gs",  vim.lsp.buf.signature_help,  "Signature help")
          map("n", "gl",  vim.diagnostic.open_float,   "Line diagnostics")
          map("n", "<F2>", vim.lsp.buf.rename,         "Rename")
          map("n", "<F4>", vim.lsp.buf.code_action,    "Code action")

          map({ "n", "x" }, "<leader>ft", function()
            local ok, conform = pcall(require, "conform")
            if ok then
              conform.format({ lsp_fallback = true, async = true })
            else
              vim.lsp.buf.format({ async = true })
            end
          end, "Format")

          -- Highlight de referencias (con cleanup en LspDetach)
          if client and client:supports_method("textDocument/documentHighlight", buf) then
            local hl = vim.api.nvim_create_augroup("my.lsp.highlight", { clear = false })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = buf,
              group = hl,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = buf,
              group = hl,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- Limpieza al desadjuntar
      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("my.lsp.detach", { clear = true }),
        callback = function(args)
          pcall(vim.lsp.buf.clear_references)
          pcall(vim.api.nvim_clear_autocmds, {
            group = "my.lsp.highlight",
            buffer = args.buf,
          })
        end,
      })

      -- ---------------------------------------------------------------
      -- Habilitar servidores
      -- ---------------------------------------------------------------
      vim.lsp.enable({
        "lua_ls",
        "ts_ls",
        "html",
        "cssls",
        "gopls",
        "pyright",
        "emmet_language_server",
      })
    end,
  },
}
