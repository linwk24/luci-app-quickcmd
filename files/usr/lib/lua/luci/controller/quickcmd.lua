module("luci.controller.quickcmd", package.seeall)

function index()
	local page

	entry({"admin", "system", "quickcmd"}, cbi("quickcmd"), _("快捷命令"), 85)
	page = entry({"admin", "system", "quickcmd", "run"}, call("run_cmd"))
	page.hidden = true
	entry({"admin", "system", "quickcmd", "exec"}, call("exec_cmd"))
	page.hidden = true
	entry({"admin", "system", "quickcmd", "delete"}, call("delete_cmd"))
	page.hidden = true
	entry({"admin", "system", "quickcmd", "add"}, call("add_cmd"))
	page.hidden = true
end

function add_cmd()
	local http = require "luci.http"
	local uci = require "luci.model.uci".cursor()

	local name = http.formvalue("name")
	local command = http.formvalue("command")
	local desc = http.formvalue("description") or ""

	if not name or not command then
		http.prepare_content("application/json")
		http.write_json({error = "Missing name or command"})
		return
	end

	uci:load("quickcmd")
	local new_section = uci:add("quickcmd", "command")
	uci:set("quickcmd", new_section, "name", name)
	uci:set("quickcmd", new_section, "command", command)
	uci:set("quickcmd", new_section, "description", desc)
	uci:commit("quickcmd")

	http.prepare_content("application/json")
	http.write_json({success = true})
end

function delete_cmd()
	local http = require "luci.http"
	local uci = require "luci.model.uci".cursor()

	local id = http.formvalue("id")
	if not id then
		http.prepare_content("application/json")
		http.write_json({error = "Missing id"})
		return
	end

	uci:load("quickcmd")
	local deleted = false
	uci:foreach("quickcmd", "command", function(s)
		if s[".name"] == id then
			uci:delete("quickcmd", id)
			deleted = true
			return false
		end
	end)

	if deleted then
		uci:commit("quickcmd")
	end

	http.prepare_content("application/json")
	http.write_json({success = deleted})
end

function run_cmd()
	local http = require "luci.http"
	local uci = require "luci.model.uci".cursor()

	local id = http.formvalue("id")
	if not id then
		http.prepare_content("application/json")
		http.write_json({error = "Missing id"})
		return
	end

	uci:load("quickcmd")
	local cmd, name
	uci:foreach("quickcmd", "command", function(s)
		if s[".name"] == id then
			cmd = s.command
			name = s.name
			return false
		end
	end)

	if not cmd then
		http.prepare_content("application/json")
		http.write_json({error = "Command not found"})
		return
	end

	http.prepare_content("application/json")
	http.write_json({
		id = id,
		name = name,
		command = cmd
	})
end

function exec_cmd()
	local http = require "luci.http"
	local uci = require "luci.model.uci".cursor()

	local id = http.formvalue("id")
	if not id then
		http.prepare_content("application/json")
		http.write_json({error = "Missing id"})
		return
	end

	uci:load("quickcmd")
	local cmd
	uci:foreach("quickcmd", "command", function(s)
		if s[".name"] == id then
			cmd = s.command
			return false
		end
	end)

	if not cmd then
		http.prepare_content("application/json")
		http.write_json({error = "Command not found"})
		return
	end

	local result = ""
	local code = 0

	local handle = io.popen(cmd .. " 2>&1")
	if handle then
		result = handle:read("*a")
		handle:close()
	else
		code = 1
		result = "Failed to execute command"
	end

	http.prepare_content("application/json")
	http.write_json({
		code = code,
		output = result
	})
end