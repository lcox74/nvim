-- Set buffer as scratch and modifiable
local function set_buffer_scratch(buf)
    vim.api.nvim_buf_set_option(buf, 'buflisted', false)
    vim.api.nvim_buf_set_option(buf, 'modifiable', true)
    vim.api.nvim_buf_set_option(buf, 'buftype', 'nofile')
end

-- Make buffer unmodifiable
local function make_buffer_unmodifiable(buf)
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
end

return {
    set_buffer_scratch = set_buffer_scratch,
    make_buffer_unmodifiable = make_buffer_unmodifiable
}
