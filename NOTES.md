# Notes

1. I chose to use rails with as few features as possible; this was pretty much an expediency choice made after starting first with sinatra, and then remembering how much work rails does for you when it comes to gem integration and configuration.
2. I plan to implement separate classes for doing the work of:
  a. HTTP request handling
    - Rails controllers
  b. XML Parsing to raw data
  c. Data validation
  d. Persistence
    - active record models, probably, to keep overhead low; I'd like to implement a repository/command/query pattern but I think it'd blow out implementation time for this exercise.
  e. Response JSON serialisation
3. I decided on strict content negotiation for the `/import` endpoint. In practice, I'd push back hard of having no authentication, but for this exercise, security by obscurity is the bare minimum.
4. I went with a functional approach for parsing, since it is done once per request, and having a `Parser` object always felt wrong to me.
  a. Using `class << self` (even for module) is the only way I know of in ruby to have private functions.
5. I used dry-validations for straightforward, declarative contracts.
