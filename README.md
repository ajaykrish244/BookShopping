# README

## Link to the Deployed Application
http://152.7.177.6:3000/

## Admin login 
* Username: AdminUser
* password: 1234

__Note__
* For this version of the app, we decided to make Admin a special user
* Thus, Admin shares the majority of views and actions with regular users
* Special actions and views reserved for Admin are guarded by checks
* Admin user is created through database in RubyMine with the above login info

## Setting Up
* Clone this repository<br>
```
https://github.ncsu.edu/anguyen9/BookShopping.git
```
* Go to the directory<br>
```
BookShopping
```
* Install required gems
```
bundle install
```
* Run the database migration to your system
```
rails db:migrate
```
* Run the seed to get the required data
```
rails db:seed
```
* Finally, run the server and open the localhost in your browser
```
rails s
```
## Running test
* test book model: type the following command into the terminal/console

```ruby -I test test/models/book_test.rb```

* test session controller: type the following command into the terminal/console

```ruby -I test test/controllers/sessions_controller_test.rb```

## Login and Sign-up
* Initial page starts with `login` and `sign-up` buttons
* `login` requires email and password
* `sign-up` required info is indicated on the page
* After `sign-up` user will need to login again to access main page

## User and Admin actions

### User
* Has `View profile`
  * Can view/edit/destroy personal account
  * View: `View profile`
  * Edit: `View profile` > `edit` > `update user`
  * destroy: `view profile` > `delete`
  * At any point, `view` will take back to the `view profile page`
  * `home page` takes to main page after login
  * View reviews written by themselves through `view profile` from main page
* Has `View all books`
  * Can `search` for books using `author`
  * Can `search` for books using `name` of book
  * Can `search` for books using `rating` of book
  * view book details through `view all books` > `show`
  * View book reviews through `view all books` > `Reviews`
  * Purchase book throuhg `view all books` > `purchase`
* Can write/edit/destroy `reviews` by doing
  * `view all books` > `reviews` > `write a new review`
  * Can only edit/destroy reviews written by themselves through
    * `view all books` > `reviews` > `show this review` > `edit/destroy this review` (if available)
    * or `view profile` > under reviews given > `show this review` > `edit/destroy this review`
* Has `View purchase history`
  * view details of purchase history through `view purhcase history` > `show`
* Has `logout`

### Admin
* Has all of the above views except for `Purchase history`
* Admin can view/edit their own profile, through `view profile`
  * Can __ONLY__ change `name` and `email`
  * Cannot destroy admin account
* Has `View all profiles` - includes profiles of all registered users
  * Can `view/edit/destroy` current profile
  * Create `new user` profile
* Can `view all books`
  * Can `Add new books`
  * Can delete a book through `view all books` > `show` > `delete this book`
  * Can edit a book through `view all books` > `show` > `edit this book`

### Race condition
* Race condition is implemented
* To test race condition, open regular browser and login as a user, and open another browser in incognito and login as another user
* Purchase the same product, make sure that one of them tries to buy all books and the other tries to buy some
* Fill out the purchase forms for both users on both browser
* Submit the filled-out purchase form for user who us trying to buy all the books and wait for transaction to go through
* Then try to submit the filled-out purchase form by the other user.  You'll see that the other user will get a notification indicating that the book they are trying to buy is out of stock

### Form Pre-filling
* When the user has entered their address, credit card number, phone number during sign up or have updated their profile with the details. During the transaction, the details gets prefilled.

### Design choices
* When a book is deleted, all reviews and transactions related to that book will also be deleted
* Admin is allowed to buy books
* Users (including admin) can only see their own purchase history
* Reviews for a book are shown through that book's page, instead of having all reviews for all books by all users clumps into one page.  __This full-fill the requirement to filter reviews by book by default__
* Reviews written by a user are show through the person's user profile
* The filter function for reviews using user name is for each book 
* The checks to make sure a user (non-admin) cannot edit other's user profile by changing the URL is implemented.  For example,
  * current logged in user has id 1
  * they try to access http://152.7.177.6:3000/users/2/edit to try to edit user with id 2 profile
  * though the URL doesn't correct itself, the information on the edit page is still of user with id 1, 
  * and even if they submit the changes, the changes would be applied to the profile of user with id 1
  * profile of user with id 2 is untouched in this case
  * you can check this using admin login and views
