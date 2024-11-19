require("luasnip.session.snippet_collection").clear_snippets("all")

local ls = require("luasnip")
local c = ls.choice_node
local d = ls.dynamic_node
local f = ls.function_node
local i = ls.insert_node
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local types = require("luasnip.util.types")
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local rep = extras.rep

-- local isn = ls.indent_snippet_node
-- local r = ls.restore_node
-- local events = require("luasnip.util.events")
-- local ai = require("luasnip.nodes.absolute_indexer")
-- local l = extras.lambda
-- local p = extras.partial
-- local m = extras.match
-- local n = extras.nonempty
-- local dl = extras.dynamic_lambda
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require("luasnip.extras.expand_conditions")
-- local postfix = require("luasnip.extras.postfix").postfix
-- local parse = require("luasnip.util.parser").parse_snippet
-- local ms = ls.multi_snippet

ls.setup({
	history = true,
	update_events = { "TextChanged", "TextChangedI" },
	enable_autosnippets = true,

	-- ext_opts = {
	--     [types.choiceNode] = {
	--         active = {
	--             virt_text = { { "●", "GruvboxOrange" } },
	--         },
	--     },
	--     [types.insertNode] = {
	--         active = {
	--             virt_text = { { "●", "GruvboxBlue" } },
	--         },
	--     },
	-- },
})

ls.add_snippets("all", {
	-- stylua: ignore
	s("ternary", {
		-- equivalent to "${1:cond} ? ${2:then} : ${3:else}"
		i(1, "cond"), t(" ? "), i(2, "then"), t(" : "), i(3, "else"),
	}),
})

local function get_emoji()
	local handle = io.popen("python ~/.scripts/emoji/choice.py")
	local result = ""
	if handle ~= nil then
		result = handle:read("*a")
		handle:close()
	end

	result = result:gsub("\n", "")
	local symbol, text = string.match(result, "(.*)#(.*)")
	return string.rep(symbol, 3) .. " " .. text
end

-- cle console.log("{EMOJI}", obj);
ls.add_snippets("all", {
	s("cle", {
		f(function()
			return 'console.log("' .. get_emoji() .. '", '
		end),
		i(1, "obj"),
		f(function()
			return ");"
		end),
	}),
})

ls.add_snippets("javascript", {
	s("funn", {
		c(1, {
			t("export "),
			t(""),
		}),
		t("function "),
		i(2, "name"),
		t("("),
		i(3, "args"),
		t({ ") {", "\t" }),
		i(4, "// function body"),
		t({ "", "}" }),
	}),
})


-- export const aaa = (args) => {
-- }

ls.add_snippets("javascript", {
	s("funa", {
		c(1, {
			t("export "),
			t(""),
		}),
		t("const "),
		i(2, "name"),
		t("= ("),
		i(3, "args"),
		t({ ") => {", "\t" }),
		i(4, "// function body"),
		t({ "", "}" }),
	}),
})

ls.add_snippets("javascript", {
	s("cln", fmt('className="{}"', { i(1, "") })),
})

ls.add_snippets("javascript", {
	s(
		"react-cmp",
		fmt(
			[[
const {} = () => {{
  return (
    <div>{}</div>
  );
}};
export default {};
  ]],
			{
				i(1, "Component"), -- First insertion node for the component name (defaults to "PrintBanner")
				i(2, "🃏name"), -- Second insertion node for the <div> content (defaults to "name")
				rep(1), -- Replicate the value from insertion node 1 (component name) to "export default {}".
			}
		)
	),
})

-- type = d(3, function(args) return sn(nil, { i(1, args[1][1] .. "Props") }) end, { 1 }),
ls.add_snippets("javascript", {
	s(
		"react-cprops",
		fmt(
			[[
import type {{ FC }} from 'react';

interface {type} {{
  name?: string;
  age?: number;
}}

const {component_name}: FC<{fc_type}> = (props) => {{
  const {{ name, age }} = props;
  return (
    <div>{div_content}</div>
  );
}};
export default {export};
]],
			{
				component_name = i(1, "Component"),
				div_content = i(2, "content"),
				export = rep(1),
				-- type = i(3, "MyType"),
				type = d(3, function(args)
					return sn(nil, { i(1, args[1][1] .. "Props") })
				end, { 1 }),
				fc_type = rep(3),
			}
		)
	),
})

ls.add_snippets("javascript", {
	s(
		"/doc",
		fmt(
			[[
	/**
	 * {}
	 **/
]],
			{
				i(1, "..."),
			}
		)
	),
})

print("luasnip loaded")
