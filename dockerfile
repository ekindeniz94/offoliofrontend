# Use the official Node.js image to build the app
FROM node:lts AS build

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Use Nginx to serve the content
FROM nginx:alpine

# Copy the build artifacts from the previous stage
COPY --from=build /usr/src/app/build /usr/share/nginx/html

# Expose the port Nginx will use
EXPOSE 80

# No command is needed since the default command in the Nginx image is to start Nginx