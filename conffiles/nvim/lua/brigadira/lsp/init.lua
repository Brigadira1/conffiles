local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "brigadira.lsp.mason"
require("brigadira.lsp.handlers").setup()
require "brigadira.lsp.null-ls"
