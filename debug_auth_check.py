import os
import sqlite3

os.chdir('C:/Users/k1715/Projects/craftmitraa/backend/craftmitra_api')
from app.core.security import verify_password

conn = sqlite3.connect('C:/Users/k1715/Projects/craftmitraa/craftmitra.db')
rows = conn.execute(
    "SELECT email, password_hash FROM users WHERE email IN (?, ?)",
    ('ramkishan.clay@craftmitra.in', 'aarav.sharma@example.com'),
).fetchall()
print('ROWS:', rows)
for email, hashed in rows:
    password = 'Artisan@123' if 'ramkishan' in email else 'Aarav@123'
    print(email, verify_password(password, hashed))
conn.close()
