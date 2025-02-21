FROM node:18
WORKDIR /app

# Install Corepack and Yarn with caching
RUN corepack enable && corepack prepare yarn@3.2.1 --activate && \
    yarn config set httpTimeout 120000 && \
    yarn config set preferOffline true

# Copy package files and install
COPY package.json yarn.lock ./
RUN yarn install --immutable

# Copy source and build
COPY . .
RUN yarn build

EXPOSE 9000
CMD ["yarn", "start"]
