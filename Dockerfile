FROM node:18-alpine
WORKDIR /app

# Enable Corepack and set Yarn version
RUN corepack enable && corepack prepare yarn@3.2.1 --activate

# Copy package files and install dependencies
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

# Copy the rest of the app and build
COPY . .
RUN yarn build

# Start the app
CMD ["yarn", "start"]
