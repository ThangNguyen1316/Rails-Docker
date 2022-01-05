# Dockerfile
# Use ruby image to build our own image
FROM ruby:3.0.2
# We specify everything will happen within the /app folder inside the container
WORKDIR /app
#update OS and install some tools 
RUN apt-get update && apt-get install -y nodejs postgresql-client
# We copy these files from our current application to the /app container
COPY Gemfile Gemfile.lock ./
# We install all the dependencies
RUN bundle install
# run rails db:setup in docker container
RUN rails db:setup
# We copy all the files from our current application to the /app container
COPY . .
# We expose the port
EXPOSE 3000
# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]