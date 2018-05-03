# README

This is an API to manage and verify users.

The available endpoints are:

* GET ----- /users ---------------- Returns a list of users.
* POST ---- /users ---------------- Create user. Params => { user: { email: user_email, image: png_image }
* PUT ----- /users/:id ------------ Update user. Params => { image: png_image }
* DELETE -- /users/:id ------------ Delete user.
* POST ---- /verify_user/:email --- Verify user. Params => { image: png_image }

Info about the tools used:
* Ruby version: 2.5.0
* Rails version: 5.1.6
* Test suite: RSpec

Check it out at: https://floating-river-22339.herokuapp.com
