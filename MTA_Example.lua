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
