-- local source = {}
--
-- ---Return whether this source is available in the current context or not (optional).
-- ---@return boolean
-- function source:is_available()
--   return true
-- end
--
-- ---Return the debug name of this source (optional).
-- ---@return string
-- function source:get_debug_name()
--   return 'debug name'
-- end
--
-- ---Return the keyword pattern for triggering completion (optional).
-- ---If this is ommited, nvim-cmp will use a default keyword pattern. See |cmp-config.completion.keyword_pattern|.
-- ---@return string
-- function source:get_keyword_pattern()
--   return [[\k\+]]
-- end
--
-- ---Return trigger characters for triggering completion (optional).
-- function source:get_trigger_characters()
--   return { '.' }
-- end
--
-- ---Invoke completion (required).
-- ---@param params cmp.SourceCompletionApiParams
-- ---@param callback fun(response: lsp.CompletionResponse|nil)
-- function source:complete(params, callback)
--   callback({
--     { label = 'January' },
--     { label = 'February' },
--     { label = 'March' },
--     { label = 'April' },
--     { label = 'May' },
--     { label = 'June' },
--     { label = 'July' },
--     { label = 'August' },
--     { label = 'September' },
--     { label = 'October' },
--     { label = 'November' },
--     { label = 'December' },
--   })
-- end
--
-- ---Resolve completion item (optional). This is called right before the completion is about to be displayed.
-- ---Useful for setting the text shown in the documentation window (`completion_item.documentation`).
-- ---@param completion_item lsp.CompletionItem
-- ---@param callback fun(completion_item: lsp.CompletionItem|nil)
-- function source:resolve(completion_item, callback)
--   callback(completion_item)
-- end
--
-- ---Executed after the item was selected.
-- ---@param completion_item lsp.CompletionItem
-- ---@param callback fun(completion_item: lsp.CompletionItem|nil)
-- function source:execute(completion_item, callback)
--   callback(completion_item)
-- end
--
-- ---Register your source to nvim-cmp.
-- require('cmp').register_source('month', source.new())

local neocomplete_lsp = {}

local source = {}

function source.is_available() end

function source.keyword_pattern() end

function source.get_trigger_characters() end

function source.complete(self, params, callback)
    local lsp_params = vim.lsp.util.make_position_params(0)
    lsp_params.context = {}
    lsp_params.context.triggerKind = params.completion_context.triggerKind
    lsp_params.context.triggerCharacter = params.completion_context.triggerCharacter
    vim.lsp.buf_request_all(0, "textDocument/completion", lsp_params, function(...)
        callback(...)
    end)
end

function source.resolve() end

function source.select_item() end

function neocomplete_lsp.setup()
    require("neocomplete.sources").register_source("nvim-lsp", source)
end

return neocomplete_lsp
