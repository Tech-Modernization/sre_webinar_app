# Scenarios

## Input validation bug

## Problem

- Start the app: `./start_app.sh`
- Create a user with a long name (try, like, 20 characters)
- Create a new project
- Refresh the page. This should yield `TypeError: props.user is undefined.`

### Troubleshooting

- Open Web Developer Console
- Should tell us that the error is in `Nav` component from `App.js:58`
- Open `Nav.js`, then go to `Components/Nav.js`
- Shows us that users are coming from `USERS_URL`, which is at `localhost:3001`
- Go to `localhost:3001/users`; should get `[]`...but we created our user, so I thought?
- Look at logs for the backend: `docker-compose logs backend`...should show nothing
- Search for `user` in `backend/app`...should point us to the model and its controller
- Since `User` inherits `ApplicationRecord`, look for its table in `backend/db/schema.rb`
- Should see that there's a limit on characters for username
- Verify that it is failing in the database: `docker-compose logs database`

### Record the demo?

- Perhaps take screenshots and explain what's happening here
