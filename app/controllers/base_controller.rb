RESULT = {
    failed: 'failed',
    ok: 'ok',
}

IS_STAGING = true

# 跨域域名
ACCESS_CONTROL_ALLOW_ORIGIN = 'https://www.9panart.com'

class BaseController < ActionController::Base

  before_filter :cors_set_access_control_headers, :cors_preflight_check

  def cors_preflight_check

    if request.method == 'OPTIONS'
      # set_response_header
      render :text => '', :content_type => 'text/plain' and return
    end
  end

  def cors_set_access_control_headers
    set_response_header
  end

  def set_response_header

    # 允许跨域
    if IS_STAGING
      headers['Access-Control-Allow-Origin'] = request.env['HTTP_ORIGIN'] unless request.env['HTTP_ORIGIN'].blank?
    else
      response.headers['Access-Control-Allow-Origin'] = ACCESS_CONTROL_ALLOW_ORIGIN
    end

    response.headers['Access-Control-Allow-Methods'] = 'POST, PUT, PATCH, DELETE, GET, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'client-p, content-type'
    response.headers['Access-Control-Max-Age'] = '1728000'
    response.headers['Access-Control-Allow-Credentials'] = 'true'
  end

end
