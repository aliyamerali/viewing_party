[![](https://img.shields.io/badge/-📓%20Turing%20School%20Project-000?style=plastic)](https://backend.turing.io/module3/projects/viewing_party)<br/>

# Viewing Party

Viewing Party is an application that enables users to search and review movie data, add other registered users as friends, and create viewing parties with friends around a given movie. It is based on the [viewing party project](https://backend.turing.io/module3/projects/viewing_party) used for Turing's Backend Module 3.

Timeframe: 9 days  
Heroku: [Viewing Party](https://glacial-scrubland-24016.herokuapp.com/)

## Contributors
- Alex Ferencz  
   [Github](https://github.com/Aferencz1987) | [LinkedIn](https://www.linkedin.com/in/alex-ferencz-75bb1288/)
- Aliya Merali  
   [Github](https://github.com/aliyamerali) | [LinkedIn](https://www.linkedin.com/in/aliyamerali/)

### Schema
![viewing_party schema (2)](https://user-images.githubusercontent.com/5446926/125636470-ace77a8b-9dac-47f6-b477-0ec885811db9.png)


## Local Setup

1. Fork and Clone the repo
2. Create account and register for an API key with [The Movie DB](https://developers.themoviedb.org/3/getting-started/authorization)
3. Install gem packages: 
   * `bundle install`
   * `bundle exec figaro install`
4. Add your API key to the `config/application.yml`
4. Setup the database: `rails db:{create,migrate}`

## Versions
- Ruby 2.7.2
- Rails 5.2.5
  
## Additional Tools
  * [WebMock](https://github.com/bblimke/webmock)
  * [Figaro](https://github.com/laserlemon/figaro)
