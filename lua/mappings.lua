require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set
local harpoon = require "harpoon"
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
--
-- harpoon commands should be <leader> + p
-- h(arpoon) is taken, p for pin/'poon

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local make_finder = function()
    local paths = {}
    for _, item in ipairs(harpoon_files.items) do
      table.insert(paths, item.value)
    end

    return require("telescope.finders").new_table {
      results = paths,
    }
  end

  require("telescope.pickers")
    .new({}, {
      prompt_title = "Harpoon",
      finder = make_finder(),
      previewer = conf.file_previewer {},
      sorter = conf.generic_sorter {},
      attach_mappings = function()
        map(
          "i",
          "<A-d>", -- your mapping here
          function()
            local state = require "telescope.actions.state"
            local selected_entry = state.get_selected_entry()
            print(vim.inspect(selected_entry.index))
            harpoon:list():removeAt(selected_entry.index)
          end
        )

        return true
      end,
    })
    :find()
end

map("n", "<leader>pa", function()
  harpoon:list():add()
end, { desc = "Add file to harpoon" })
map("n", "<leader>pe", function()
  toggle_telescope(harpoon:list())
end, { desc = "Open harpoon window" })

map("n", "<leader>p1", function()
  harpoon:list():select(1)
end, { desc = "Select first item in harpoon list" })
map("n", "<leader>p2", function()
  harpoon:list():select(2)
end, { desc = "Select second item in harpoon list" })
map("n", "<leader>p3", function()
  harpoon:list():select(3)
end, { desc = "Select third item in harpoon list" })
map("n", "<leader>p4", function()
  harpoon:list():select(4)
end, { desc = "Select fourth item in harpoon list" })
