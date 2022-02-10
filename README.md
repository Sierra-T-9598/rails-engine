# Rails Engine Lite
> Rails API application exposing data for the development of a fictitious E-commerce Application. 

![languages](https://img.shields.io/github/languages/top/Sierra-T-9598/rails-engine?color=red)
![PRs](https://img.shields.io/github/issues-pr-closed/Sierra-T-9598/rails-engine)
![rspec](https://img.shields.io/gem/v/rspec?color=blue&label=rspec)
![simplecov](https://img.shields.io/gem/v/simplecov?color=blue&label=simplecov)
![contributors](https://img.shields.io/github/contributors/Sierra-T-9598/rails-engine?color=orange)


Built as a Back-End project for Turing School of Software and Design, Module 3, Rails Engine Lite serves as a API for viewing and interacting with the database being used to power a fictitious E-commerce site. 

## Requirements for Mac
### Versions
`Ruby 2.7.2`
`Rails 5.2.6`

### Gems 
```rspec-rails
pg
pry
simpleCov
shoulda-Matchers
factory_bot_rails
faker
jsonapi-serializer
```

### Database Schema
![Screen Shot 2022-01-03 at 7 24 37 PM](https://user-images.githubusercontent.com/79548116/147997637-ef70102b-8b85-4349-9cc7-ecac543a50e1.png)

### Set Up
On your local system, open a terminal session to run the following commands:
1. Clone this repository `$ git clone git@github.com:Sierra-T-9598/rails-engine.git`
2. Navigate to the newly cloned directory `$ cd rails-engine`
3. If bundler is not installed run `$ gem install bundler` 
4. If or after bundler is installed run `$ bundle install` to install the required Gems
5. If errors occur, check for proper installation and versions of `bundler`, `ruby`, and `rails`
6. Set up the database locally with `$ rails db:{:drop,:create,:migrate,:seed}` *Note:* you may see lots of output including some warnings/errors from pg_restore that you can ignore.
7. Seed the databse with the command `$ rails db:schema:dump`
8. Open your text editor and check to see that `schema.rb` exists
9. You may also run the RSpec test suite locally with the command `$ bundle exec rspec` to ensure everything is functioning as expected.

### Use
On your command line: 
1. Run `$ rails s` in order to start the server locally access the app through a web browser
2. Open a web browser and navigate to http://localhost:3000/
3. Now you may explore the API using the available endpoints listed below!

## Usage examples: Available Endpoints

### Merchant Information

**GET** /api/v1/merchants

Description: Get the data of all merchants

___
**GET** /api/v1/merchants/:id

Description: Get details about one merchant found by id

___
**GET** /api/v1/merchants/:merchant_id/items

Description: Get all items associated with a merchant

### Merchant Search
___
**GET** /api/v1/merchants/find

Description: Search for a single merchant by name query. *Note:* The returned query will be the first match, alphabetically. 

Accepted Parameters:

| name | data type | description | optional/required | example |
| --- | --- | --- | --- | --- |
| name | string | case-insensitive search term; includes partial matches | optional | /api/v1/merchants/find?name=<your_search_here> |

* * *

### Item Information

**GET** /api/v1/items

Description: Get the data of all items

___
**GET** /api/v1/items/:id

Description: Get details about one item found by id

___
**POST** /api/v1/items

Description: Create a new item. Name, description, unit price, and merchant id are required.

Example:
```
{
  "name": "The Big Bean",
  "description": "Delicious Coffee",
  "unit_price": 4000.0,
  "merchant_id": 1
}
```
___
**PUT** /api/v1/items/:id

Description: Update one or more attributes of an item

___
**DELETE** /api/v1/items/:id

Description: Delete an item

___
**GET** /api/v1/items/:item_id/merchant

Description: Get the merchant associated with an item

### Item Search

___
**GET** /api/v1/items/find_all

Description: Search for all items that match search by name OR price; price filters can include min_price and/or max_price, but cannot be combined with a name query. *Note:* All queries are ordered alphabetically. 

Accepted Parameters:

| name | data type | description | optional/required | example |
| --- | --- | --- | --- | --- |
| name | string | case-insensitive search term; includes partial matches | optional | /api/v1/items/find_all?name=<your_search_here> |
| min_price | float | minimum price; returns items with prices greater than or equal to the provided filter | optional | /api/v1/items/find_all?min_price=4500.0 |
| max_price | float | maximum price; returns items with prices less than or equal to the provided filter | optional | /api/v1/items/find_all?min_price=6000.0 |
| min_price/max_price| floats | returns the items within (or equal to) the provided price range | optional | /api/v1/items/find_all?min_price=4500.0&max_price=6000.0 |

## Release History
* 0.1.0
    * Basic data exposure complete

## Contributors 
<a href="https://github.com/Sierra-T-9598/rails-engine/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=Sierra-T-9598/rails-engine" />
</a>

<!-- Made with [contrib.rocks](https://contrib.rocks). -->

Sierra Tucker: [Github](https://github.com/Sierra-T-9598)|[LinkedIn](https://www.linkedin.com/in/sierra-tucker-a254201a8/)

## Contributing

1. Fork it (<https://github.com/yourname/yourproject/fork>)
2. Create your feature branch (`git checkout -b feature/fooBar`)
3. Commit your changes (`git commit -am 'Add some fooBar'`)
4. Push to the branch (`git push origin feature/fooBar`)
5. Create a new Pull Request

## Thanks for Reading! 🙏 👨‍💻 ✨
