# SL Connect
## What is it?
It is an app which connects skilled laborers with potential employers. Employers and Laborers both can login into the app and register.
Employers can find the laborers registered and the laborers get exposure from potential employers.
## Features
* Employer and Laborer login
* OTP Authentication
* User Login is saved unless logout button is clicked
* Notification to targeted Employer and Laborer using OneSignal API
* Local Calendar for Laborer to keep count of their work
* Online toggle for labore which tells whether they are available to be booked
## How does it work
* Employer logins and creates an profile
* Laborer logins and creates their profile with their skills selected using a checkbox
* Laborer turns the availability toggle on or off
* If the toggle is on, that laborer is visible on the employer side
* Employer can give a booking request to the employer by giving a date range and the amount of money that he can provide for the job and the job description
* Laborer gets a push notification about the work
* He can click on the notification to go to the notifications page in the app
* If he accepts the work, the booking is added to the bookings page and the booking accepted push notification message is sent back to the employer. Else rejection push notification message is sent back.
## Technologies Used
* Flutter for Front-End and Back-End
* Firebase for Database
* Firebase Authentication
* OneSignal API for Notifications
## Screenshots
### Employer Login
![Category View](https://github.com/navaneethku/slconnect/assets/88205492/6284ff71-1b90-4bf0-8dbc-a3e4272f452e)
![Category to Profile View](https://github.com/navaneethku/slconnect/assets/88205492/d115477f-e96b-4581-a0ab-9bd8177107db)
![Booking Screen](https://github.com/navaneethku/slconnect/assets/88205492/9cea18f6-1b17-4411-bd65-0a6ce5e04c80)
### Laborer Login
![Laborer Home Screen](https://github.com/navaneethku/slconnect/assets/88205492/4badc96d-912e-46c6-a174-d6592de30c4b)
![Notification View](https://github.com/navaneethku/slconnect/assets/88205492/a9fbfc93-72b2-47ca-af4a-9fd7b27909e1)
![Notification View Expanded](https://github.com/navaneethku/slconnect/assets/88205492/ba04fdc4-67e9-45cf-b35c-98bfa43f8bac)
![Booking View](https://github.com/navaneethku/slconnect/assets/88205492/57ebbcd4-d316-458a-8dbc-0ae91be2525c)
