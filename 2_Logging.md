# Logging
---
So we know we have an issue when a username is more than 20 characters long. But we dont know why. We assumed something along the way maybe we can narrow in on it using some Developer Hacky Debug (tm)

---
## Logging 1.0
We add some puts to the rail application around the user controller. We know theres an issue with a user being created but no being there.

XXX: add screen show of output of a user being 'created'

With the user not being created we can add some validations, and kick back an error when `User.create(user_params).valid?` is `false`

---
## Logging 1.1
Dumping information to SYSOUT is great and all, doubly so in a containerized world, but with formatting all over the place, it can be hard to search and query. It also adds a lot of visual noise. Logging libaries that allow us to standardize the output of things we're intrested in can address these issues. 

XXX: Screen shot of log.warn 

---
## Logging 1.2

So We know theres an issue that _some_ users are being created. But it would be great if there was a way to capture everything thats happening. A lot of frameworks have tools that allow you enable a lot of logging, and furhter allow you to give it formatting parameters so that tools like Splunk can ingest them in a well formated way. 