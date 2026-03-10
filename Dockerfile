FROM alpine:3.19

# Install Lua 5.1 and luarocks from Alpine packages
RUN apk add --no-cache lua5.1 luarocks gcc musl-dev lua5.1-dev

# Set working directory
WORKDIR /app

# Install test dependencies
RUN luarocks-5.1 install busted
RUN luarocks-5.1 install luacheck
