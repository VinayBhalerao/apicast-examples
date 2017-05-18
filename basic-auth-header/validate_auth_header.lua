local apicast = require('apicast')
local configuration_loader = require('configuration_loader').new()
local proxy = require 'proxy'

local _M = {
  _VERSION = '1.0',
  _NAME = 'validate auth header'
}

function _M.new()
  return setmetatable(_M, { __index = apicast.new() })
end


local function validate_auth_header()
	local req_headers = ngx.req.get_headers()

	if req_headers["Authorization"] ~= nil then
	  
	  local cjson = require "cjson"
	  local res = ngx.location.capture("/validate-auth-endpoint")
	  local value = cjson.decode(res.body)

	  if res.status ~= 200 or value.Valid ~= true then
	    ngx.exit(ngx.HTTP_UNAUTHORIZED)
	  end
	else
	  ngx.exit(ngx.HTTP_UNAUTHORIZED)
	end
end

function _M:rewrite()

  validate_auth_header()

  ngx.on_abort(_M.cleanup)

  ngx.var.original_request_id = ngx.var.request_id

  local host = ngx.var.host
  -- load configuration if not configured
  -- that is useful when lua_code_cache is off
  -- because the module is reloaded and has to be configured again

  local configuration = configuration_loader.rewrite(self.configuration, host)

  local p = proxy.new(configuration)
  p.set_upstream(p:set_service(host))
  ngx.ctx.proxy = p
end

return _M