return {
  "prichrd/netrw.nvim",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("netrw").setup({ use_devicons = true })

    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      callback = function()
        if vim.bo.filetype == "netrw" then
          require("netrw.ui").embelish(vim.api.nvim_get_current_buf())
        end
      end,
    })

    -- BufEnter for the initial netrw buffer fires before lazy finishes loading,
    -- so re-embellish after startup completes.
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = vim.schedule_wrap(function()
        if vim.bo.filetype == "netrw" then
          require("netrw.ui").embelish(vim.api.nvim_get_current_buf())
        end
      end),
    })
  end,
}
