
# Blooper

I have been asked to create a simple chat app API which 'bloops' out words which are deemed 'sensitive'. I have created CRUD endpoints for internal use and two external use endpoints.


## Project Requirements


### CRUD endpoints (internal consumption)

I have created CRUD endpoints for the users and messages tables in my database. They can be found in the `BlooperAPI/Controlles_Internal` folder

### Business logic endpoints (external consumption)

I have created 2 external endpoints, one to `GET` messages and one to `POST` a message. They can be found in the `BlooperAPI/Controlles_External` folder

#### GET

This is almost identical to the equivilant internal endpoint, except for the fact that messages are sorted by `created_at` in `ASC` order.

#### POST

The external `POST` method takes the text input and 'bloops' out the sensitive words. The new string is then returned, so that it is possible for the user to see the edited text.

### How this would be deployed

Assuming this would be an added feature on an existing program (as described in the brief) you could simply the `Blooper` method to the existing `Message` controller, as I have done in this project. You will also need to add another `POST` endpoint which implements this method, or you could simply alter the existing external `POST` endpoint by running `text` through the `Blooper` method.
## Run Locally

I have included all necessary stored procedures and SQL queries required in this repo to create the database.

