FROM ruby:3.0 AS development

ARG APP_DIR
WORKDIR $APP_DIR

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
