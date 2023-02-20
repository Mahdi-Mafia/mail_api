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
