local utils = require "ctools-nvim.utils"

local ctools = {}

function ctools.setup(opts)
  vim.keymap.set('n', "<leader>c<Tab>", ctools.toggle_class_file, { desc = "CTools: [C]lass file toggle" })
end

function ctools.toggle_class_file()
  local cwd = vim.fn.getcwd()
  local fullname = vim.api.nvim_buf_get_name(0);
  local _, filename, extension = utils.get_file_info(fullname)

  if extension == "c" or extension == "cpp" then
    local files_found = vim.fn.glob(cwd .. "/**/*.h", false, true)
    files_found = utils.merge_lists(files_found, vim.fn.glob(cwd .. "/**/*.hpp", false, true))

    for _, item in pairs(files_found) do
      local _, name, ext = utils.get_file_info(item)
      if filename == name then
        vim.cmd("e " .. item)
        return
      end
    end

    print("Couldn't find class file for " .. filename)
  elseif extension == "h" or extension == "hpp" then
    local files_found = vim.fn.glob(cwd .. "/**/*.c", false, true)
    files_found = utils.merge_lists(files_found, vim.fn.glob(cwd .. "/**/*.cpp", false, true))

    for _, item in pairs(files_found) do
      local _, name, ext = utils.get_file_info(item)
      if filename == name then
        vim.cmd("e " .. item)
        return
      end
    end

    print("Couldn't find class file for " .. filename)
  else
    print("Current file " .. filename .. " is not a c file")
  end
end

ctools.setup()
return ctools
