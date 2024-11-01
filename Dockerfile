# Pull Node Image
FROM node:18

# Set the WORKDIR in the container
WORKDIR /usr/src/app

# Copy the package.json to the working directory
COPY package.json ./

RUN apt get nodejs -y

# Install NPM
RUN npm install

#install express
RUN npm install express

# Copy the rest of the code
COPY . .

# Expose the port the app 
EXPOSE 5000

# Define the command to run the app
CMD ["node", "index.js"]
