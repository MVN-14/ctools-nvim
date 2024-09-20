local utils = {}

function utils.merge_lists(list1, list2)
  local new_list = {}

  for _, value in ipairs(list1) do
    table.insert(new_list, value)
  end

  for _, value in ipairs(list2) do
    table.insert(new_list, value)
  end

  return new_list
end

function utils.get_file_info(path)
  return path:match("^(.-)([^\\/]-)%.([^\\/%.]-)%.?$")
end

return utils
