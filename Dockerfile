FROM node:18 AS builder
WORKDIR /app

# Install Corepack and Yarn 3.2.1
RUN corepack enable && corepack prepare yarn@3.2.1 --activate

# Copy package files and install with caching
COPY package.json yarn.lock ./
RUN yarn config set httpTimeout 120000 && \
    yarn install --immutable --prefer-offline

# Copy source and build
COPY . .
RUN yarn build

# Final stage: slim runtime image
FROM node:18-slim
WORKDIR /app
COPY --from=builder /app .
EXPOSE 9000
CMD ["yarn", "start"]
