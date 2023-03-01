# Questions and Answers
## What problem does it solve?
This rails app implements a solution to the the problem outlined in [SPEC.md](SPEC.md); in brief:
Implement a web service that:
- Can receive data about student test responses in XML format
- Saves each student test response
- Can collate all results for a given test and return a statistics summary in JSON format

## What was your specific contribution?
I wrote it! It is a solution to the coding challenge for my interview process at a previous employer. It took me about 3-4 hours.

## What do you like about that piece of code?
- I think I did a decent job of segmenting it into single responsibility classes
- I think it's reasonably well tested
- I enjoyed using dry-validation for XML schema validation

## How else could that problem be solved?
The major change that could be made would be for the statistics summaries to be pre-built and stored as test results came in; this would have the advantage of making statistics reporting constant time, which could be important for very large test result sets. Another possibile change might be to implement the service using my personal favourite pattern: event sourcing; this would make building statistics projections trivial, but is also almost definitely overkill for this system.

## What tradeoffs did you make? 
I skipped a couple things so as to keep my time investment down:
- No authentication/authorisation! This absolutely makes this service not-production-ready, and would need to be implemented before shipping it.
- I put some minor business logic into the controller layer (e.g. directly invoking contracts and persistence instead of passing it off to a business object) and in the model namespace (I personally like an `app/domain` directory for business logic.
