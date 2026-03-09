FROM lua:5.1

# Install luarocks
RUN apt-get update && apt-get install -y luarocks && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy project files
COPY . /app

# Install test dependencies
RUN luarocks install busted
RUN luarocks install luacheck

# Run tests
CMD ["busted", "specs/", "--verbose"]
