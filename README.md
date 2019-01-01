# Little Shop: Myxology
A Turing School group project created with Rails.


![Myxology](/.readme/mixology.jpg)


 We created an online application where visitors, registered users, merchants, and admins have a variety of interactions with our fictitious shop. Each user type has some degree of authentication and authorization on our site. A user must be registered before checking out, but a visitor can shop up to checkout without being registered. Merchants can fulfill orders according to their inventory. Admins have authorization to enable and disable a user, as well as upgrading or downgrading a user or merchant, along with other functionality.

![Myxology](/.readme/cocktails.jpg)

## Learning Goals

* Advanced Rails routing (nested resources and namespacing)
* Advanced ActiveRecord for calculating statistics
* Average HTML/CSS layout and design for UX/UI
* Session management and use of POROs for shopping cart
* Authentication, Authorization, separation of user roles and permissions

## Getting Started && Prerequisites

You will need Rails v 5.1.
```
gem install rails -v 5.1
```
Clone down this repo!

```
git clone https://github.com/cebarks/littleshop
```

### Installing

From your terminal, navigate into the little_shop directory:

```
cd little_shop
```

Make sure your gemfile is up to date:

```
bundle
bundle update
```
Establish a database:

```
rake db:{drop,create,migrate,seed}
```
Start your server:

```
rails s
```

Open your browser (best functionality in Chrome).

`localhost:3000`

Welcome to our dev environment!


## Running the tests

Your location should be the root directory of the project (`little_shop`).

From the command line run `rspec`
(This can take a moment)

`Green` is passing.
`Red` is failing.

We used `rspec`, `capybara`, and `shoulda-matchers` for testing.
We also used `FactoryBot` and `Faker` gems.

##### Example of a feature test:

![Alt text](/.readme/feature_test.jpg)

##### Example of a model test:

![Alt text](/.readme/model_test.jpg)

#### MVC
This project was a huge exploration into the M(odel) V(iew) C(ontroller) software architecture pattern.
We also worked with namespacing routes and authorization and authentication.

##### Example of a namespaced Controller:

![Alt text](/.readme/admin_users.jpg)

##### Example of a model:

![Alt text](/.readme/model_page.jpg)

##### Example of a view:

![Alt text](/.readme/cart_show.jpg)

## ActiveRecord Queries and Statistics
We worked with relational databases and queries with many to many relationships.

##### Our Schema

![Alt text](/.readme/schema.jpg)

##### Example of Queries

![Alt text](/.readme/queries.jpg)

## Deployment

Our app is deployed on heroku at: [Myxology](https://limitless-everglades-19318.herokuapp.com)

`https://limitless-everglades-19318.herokuapp.com`

## Built With

* `Rails` (and all it's magic)
* Along with these gems:
  * `Bcrypt`
  * `FactoryBot`
  * `Faker`
  * `Rspec`
  * `Capybara`
  * `ShouldaMatchers`...and more!

## Contributing Members

* Anten Skrabec
* Mary Goodhart
* Michael Clampett

With assistance from: * Mary Bork


## Acknowledgments

Project Leads/Instructors:
* Ian Douglas
* Dione Wilson
