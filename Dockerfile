FROM node:18
WORKDIR /app

# Copy package files first
COPY package.json yarn.lock ./

# Install Corepack, Yarn, and configure
RUN corepack enable && \
    corepack prepare yarn@3.2.1 --activate && \
    yarn config set httpTimeout 120000 && \
    yarn config set preferOffline true && \
    yarn install --immutable

# Copy source and build
COPY . .
RUN yarn build

EXPOSE 9000
CMD ["yarn", "start"]
