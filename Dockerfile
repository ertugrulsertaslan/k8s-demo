# Let's use the latest version of Node.js
FROM node:16

# Create the working directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install the dependencies
RUN npm install

# Copy the application files
COPY . .

# Expose the port the application will run on
EXPOSE 8080

# Start the application
CMD ["node", "app.js"]
