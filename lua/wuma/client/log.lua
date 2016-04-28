
WUMA = WUMA or {}
WUMA.Log = {}

function WUMA.Log.ServerLog(msg,...)
	local args = { ... }
	if args then
		msg = WUMA.SafeFormat(msg,args)
	end
	WUMA.Files.Append("log.txt",msg)
	msg = "[WUMA] " .. msg 
	Msg(msg.."\n")
end
WUMALog = WUMA.Log.ServerLog --To save my fingers

function WUMA.Log.ChatPrint(msg,...)
	local args = { ... }
	if args then
		msg = WUMA.SafeFormat(msg,args)
	end
	LocalPlayer():ChatPrint(msg)
end
WUMAChatPrint = WUMA.Log.ChatPrint --To save my fingers

function WUMA.Log.DebugLog(msg,...)
	local args = { ... }
	if args then
		msg = WUMA.SafeFormat(msg,args)
	end
	Msg(msg.."\n")
end
WUMADebug = WUMA.Log.DebugLog

function WUMA.Log.Error(msg)
	WUMALog("WUMA ERROR!\n")
	Msg(msg.."\n")
	debug.Trace()
end
WUMAError = WUMA.Log.Error --To save my fingers

function WUMA.ExtractValue(args)
	local value = args[1]
	table.remove(args,1)
	return value,args
end

function WUMA.SafeFormat(msg,args)
	if not args then return string.format(msg,"NO_ARGS") end
	msg = tostring(msg)
	if (table.Count(args) == 1) then
		args[1] = tostring(args[1]) or "NO_DATA"
		msg = string.format(msg,args[1])
	else
		for k,v in pairs(args) do
			if  not v then
				args[k] = "NO_DATA"
			else
				args[k] = tostring(args[k])
			end
		end
		msg = string.format(msg,unpack(args))
	end
	return msg
end