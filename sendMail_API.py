import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from flask import Flask, request
app = Flask(__name__)

def send_email(sender_email, sender_password, receiver_email, subject, body):
    msg = MIMEMultipart()
    msg['From'] = sender_email
    msg['To'] = receiver_email
    msg['Subject'] = subject
    msg.attach(MIMEText(body, 'plain'))
    # connect to SMTP server
    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    # login mail server
    server.login(sender_email, sender_password)
    # send email
    server.sendmail(sender_email, receiver_email, msg.as_string())
    server.quit()
@app.route('/send_email', methods=['POST'])
def send_email_api():
    sender_email = request.form['sender_email']
    sender_password = request.form['sender_password']
    receiver_email = request.form['receiver_email']
    subject = request.form['subject']
    body = request.form['body']
    send_email(sender_email, sender_password, receiver_email, subject, body)

    return 'successfully'

if __name__ == '__main__':
    app.run()
