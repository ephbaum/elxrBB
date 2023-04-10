# Use the official Elixir image as the base
FROM elixir:1.14-alpine

# Install required build dependencies
RUN apk add --update \
  build-base \
  git \
  nodejs \
  npm \
  postgresql-dev \
  yarn

ARG UID=1000
ARG GID=1000

RUN addgroup -g $GID user \
    && adduser -u $UID -G user -D -s /bin/sh user

RUN mkdir -p /app
RUN chown -R user:user /app
COPY --chown=user:user . .

# Set the working directory
WORKDIR /app

USER user

# Install Hex and Rebar
RUN mix local.hex --force && \
    mix local.rebar --force


# Copy required files
COPY mix.exs mix.lock ./

# Fetch dependencies
RUN mix do deps.get, deps.compile

# Copy the rest of the application
COPY . .

# Compile the application
RUN mix do compile

# Build the assets
RUN mix phx.digest

# Expose the application port
EXPOSE 4000

# Set the default command to run the Phoenix server
CMD ["mix", "phx.server"]
