require("luci.cbi")

local map = Map("quickcmd", translate("快捷命令管理"),
	translate("在此添加常用的Shell命令，点击执行时会弹出确认对话框"))

local section = map:section(TypedSection, "command", translate("命令列表"))
section.anonymous = false
section.addremove = true
section.template = "cbi/section_quickcmd"

local name = section:option(Value, "name", translate("名称"))
name.placeholder = translate("例如: 重启网络")

local command = section:option(Value, "command", translate("命令"))
command.placeholder = translate("例如: /etc/init.d/network restart")

local desc = section:option(Value, "description", translate("描述"))
desc.placeholder = translate("可选的命令说明")

return map