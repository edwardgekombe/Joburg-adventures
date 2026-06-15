const express = require('express');
const nodemailer = require('nodemailer');
const cors = require('cors');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;
const RECIPIENT = process.env.RECIPIENT_EMAIL || 'momanyimangabo@gmail.com';

if (!process.env.SMTP_HOST || !process.env.SMTP_USER || !process.env.SMTP_PASS) {
  console.warn('SMTP credentials not set. Set SMTP_HOST, SMTP_PORT (optional), SMTP_USER, SMTP_PASS');
}

app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

const transporter = nodemailer.createTransport({
  host: process.env.SMTP_HOST,
  port: process.env.SMTP_PORT ? parseInt(process.env.SMTP_PORT) : 587,
  secure: process.env.SMTP_SECURE === 'true',
  auth: {
    user: process.env.SMTP_USER,
    pass: process.env.SMTP_PASS,
  },
});

app.post('/send-message', async (req, res) => {
  try {
    const { name, _replyto, phone, package: pkg, travel_date, travelers, message } = req.body;
    const mailOptions = {
      from: process.env.SMTP_FROM || process.env.SMTP_USER,
      to: RECIPIENT,
      subject: `Contact form: ${name || 'New message'}`,
      replyTo: _replyto || undefined,
      text: `Name: ${name || ''}\nEmail: ${_replyto || ''}\nPhone: ${phone || ''}\nPackage: ${pkg || ''}\nDate: ${travel_date || ''}\nTravelers: ${travelers || ''}\n\nMessage:\n${message || ''}`,
      html: `<p><strong>Name:</strong> ${name || ''}</p><p><strong>Email:</strong> ${_replyto || ''}</p><p><strong>Phone:</strong> ${phone || ''}</p><p><strong>Package:</strong> ${pkg || ''}</p><p><strong>Travel Date:</strong> ${travel_date || ''}</p><p><strong>Travelers:</strong> ${travelers || ''}</p><hr/><p>${message || ''}</p>`
    };
    await transporter.sendMail(mailOptions);
    return res.json({ ok: true });
  } catch (err) {
    console.error(err);
    return res.status(500).json({ ok: false, error: err.message });
  }
});

app.listen(PORT, () => console.log(`Server listening on ${PORT}`));
