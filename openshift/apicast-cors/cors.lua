
cal apicast = require('apicast')
local configuration_loader = require('configuration_loader').new()
local proxy = require 'proxy'

local _M = {
  _VERSION = '3scale-amp20/apicast-gateway',
  _NAME = 'APIcast with CORS'
}

function _M.new()
  return setmetatable(_M, { __index = apicast.new() })
end

local function set_cors_headers()
  ngx.header['Access-Control-Allow-Headers'] = ngx.var.http_access_control_request_headers
  ngx.header['Access-Control-Allow-Methods'] = ngx.var.http_access_control_request_method
  ngx.header['Access-Control-Allow-Origin'] = ngx.var.http_origin
  ngx.header['Access-Control-Allow-Credentials'] = 'true'
end

local function cors_preflight_response()
  local cors_preflight = ngx.var.request_method == 'OPTIONS' and 
                          ngx.var.http_origin and ngx.var.http_access_control_request_method

  -- for CORS preflight sent by the browser, return a 204 status code
  if cors_preflight then
    ngx.status = 204
    return ngx.exit(ngx.status)
  end
end

function _M:rewrite()

  set_cors_headers()
  cors_preflight_response()

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
