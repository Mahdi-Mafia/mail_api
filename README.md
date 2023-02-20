
## How to Use This API
```
python sendMail_API.py
```
curl usage :

```bash
curl -X POST -d 'sender_email=example@gmail.com' \
             -d 'sender_password=password' \
             -d 'receiver_email=recipient@example.com' \
             -d 'subject=Test email from curl' \
             -d 'body=This is a test email.' \
             http://localhost:5000/send_email
```
or
```bash
curl -X POST http://localhost:5000/send_email \
-H 'Content-Type: application/x-www-form-urlencoded' \
-d 'sender_email=example@gmail.com' \
-d 'sender_password=password' \
-d 'receiver_email=recipient@example.com' \
-d 'subject=Test email from curl' \
-d 'body=This is a test email.'
```
#
### MTA-SA example:
 
[curl](https://wiki.multitheftauto.com/wiki/Modules/cURL)

Server Side : Lua

```lua
function send_email(sender_email, sender_password, receiver_email, subject, body)
    local curl = require('curl')

    local c = curl.easy_init()
    c:setopt_url('http://localhost:5000/send_email')
    c:setopt_post(true)
    c:setopt_httpheader({
        'Content-Type: application/x-www-form-urlencoded'
    })
    c:setopt_postfields(string.format(
        'sender_email=%s&sender_password=%s&receiver_email=%s&subject=%s&body=%s',
        sender_email,
        sender_password,
        receiver_email,
        subject,
        body
    ))

    local response_body = {}
    c:setopt_writefunction(table.insert, response_body)
    c:perform()
    c:close()

    return table.concat(response_body)
end
-- example
local sender_email = 'example@gmail.com'
local sender_password = 'password'
local receiver_email = 'receiveremail@example.com'
local subject = 'Test email from MTA SA'
local body = '(Hello World) my author: https://github.com/Mahdi-Mafia'

local response = send_email(sender_email, sender_password, receiver_email, subject, body)
print(response)
```
#
### FiveM example:


```lua
function send_email(sender_email, sender_password, receiver_email, subject, body)
    local curl_handle = curl_init()

    curl_easy_setopt(curl_handle, CURLOPT_URL, "http://localhost:5000/send_email")
    curl_easy_setopt(curl_handle, CURLOPT_POST, true)

    local post_fields = string.format(
        "sender_email=%s&sender_password=%s&receiver_email=%s&subject=%s&body=%s",
        sender_email,
        sender_password,
        receiver_email,
        subject,
        body
    )

    curl_easy_setopt(curl_handle, CURLOPT_POSTFIELDS, post_fields)
    curl_easy_setopt(curl_handle, CURLOPT_HTTPHEADER, {"Content-Type: application/x-www-form-urlencoded"})

    local response_body = {}
    curl_easy_setopt(curl_handle, CURLOPT_WRITEFUNCTION, function (buf, size, nmemb, userp)
        table.insert(response_body, ffi.string(buf, size * nmemb))
        return size * nmemb
    end)

    curl_easy_perform(curl_handle)
    curl_easy_cleanup(curl_handle)

    return table.concat(response_body)
end

-- example
local sender_email = "example@gmail.com"
local sender_password = "password"
local receiver_email = "receiveremail@example.com"
local subject = "Test email from FiveM"
local body = "(Hello World) my author: https://github.com/Mahdi-Mafia"

local response = send_email(sender_email, sender_password, receiver_email, subject, body)
print(response)
```

## 🛠
Python, Lua, Curl


## License

[MIT](https://choosealicense.com/licenses/mit/)




