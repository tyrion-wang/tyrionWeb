IS_STAGING = true
# 跨域域名
ACCESS_CONTROL_ALLOW_ORIGIN = 'https://www.party.com'

MOBILE_EXPIRE_TIME = 3.days # APP超时时间

HTTP_STATUS = {
    :session_timeout => 901,
    :new_version => 902,
    :force_update_version => 903,
    # :shopping_error => 904,
    # :access_denied => 905
}

RESULT = {
    failed: 'failed',
    ok: 'ok',
}