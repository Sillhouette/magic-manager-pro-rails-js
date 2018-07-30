# MTG Manager Pro

Manage your MTG cards and create decks from them.

## Installation

Follow these easy steps to install and start the app:

### Set up Rails app

First, fork and clone this repo

Then, install the gems required by the application:

    bundle

Next, execute the database migrations/schema setup:

	bundle exec rake db:setup

After, start your rails console by typing

  rails c

Then, use the following command to populate the database of magic_cards

  MagicCard.parse_json

Be aware: This process can take a long time

### Start the app

Start the server using the following command to allow facebook logins:

  thin start --ssl

You can find your app now by pointing your browser to [https://0.0.0.0:3000](http://0.0.0.0:3000). If everything worked you can create a new account a log in with it

## Contributors guide

## How to contribute to Ruby on Rails

#### **Did you find a bug?**

* **Ensure the bug was not already reported** by searching on GitHub under [Issues](https://github.com/Sillhouette/magic-manager-pro-rails/issues).

* If you're unable to find an open issue addressing the problem, [open a new one](https://github.com/Sillhouette/magic-manager-pro-rails/issuesnew). Be sure to include a **title and clear description**, as much relevant information as possible, and a **code sample** or an **executable test case** demonstrating the expected behavior that is not occurring.

#### **Did you write a patch that fixes a bug?**

* Open a new GitHub pull request with the patch.

* Ensure the PR description clearly describes the problem and solution. Include the relevant issue number if applicable.

Thanks!

MTG Manager Pro Team

* This project has been licensed under the MIT open source license.
