return {
  {
    "neogit",
    after = function()
      require("neogit").setup({})
    end,
    keys = {
      { "<leader>gg", "<cmd>:Neogit<cr>", desc = "Neogit status" },
    },
    wk = {
      { "<leader>g", desc = "Git" },
    },
  },

  {
    "gitsigns.nvim",
    event = "DeferredUIEnter",
    after = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          -- Navigation
          WK.add({
            {
              "]c",
              function()
                if vim.wo.diff then
                  vim.cmd.normal({ "]c", bang = true })
                else
                  gs.nav_hunk("next")
                end
              end,
            },

            {
              "[c",
              function()
                if vim.wo.diff then
                  vim.cmd.normal({ "[c", bang = true })
                else
                  gs.nav_hunk("prev")
                end
              end,
            },

            -- Actions
            { "<leader>gs", gs.stage_hunk, desc = "Stage hunk" },
            { "<leader>gr", gs.reset_hunk, desc = "Reset hunk" },

            { "<leader>gS", gs.stage_buffer, desc = "Stage buf" },
            { "<leader>gR", gs.reset_buffer, desc = "Reset buf" },

            { "<leader>gp", gs.preview_hunk, desc = "Preview hunk" },
            { "<leader>gi", gs.preview_hunk_inline, desc = "Preview hunk inline" },

            {
              "<leader>gb",
              function()
                gs.blame_line({ full = true })
              end,
              desc = "Blame line",
            },

            { "<leader>gtb", gs.toggle_current_line_blame },
            { "<leader>gtw", gs.toggle_word_diff },

            { "<leader>gd", gs.diffthis },
            {
              "<leader>gD",
              function()
                gs.diffthis("~")
              end,
            },
            { "<leader>gtd", gs.toggle_deleted },

            {
              mode = { "v" },
              {
                "<leader>gs",
                function()
                  gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end,
              },
              {
                "<leader>gr",
                function()
                  gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
                end,
              },
            },
            {
              mode = { "o", "x" },
              { "gh", ":<C-U>Gitsigns select_hunk<CR>" },
            },
          }, { buffer = bufnr })
        end,
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })
    end,
  },
}
