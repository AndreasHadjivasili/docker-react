# Specify the base image for first phase
FROM node:16-alpine as builder
#Change working dir
WORKDIR /app
# Copy all the code from development to production
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
# Specify the base image for second phase
FROM nginx
#This line specifies that we want to copy something from the previous phase
COPY --from=builder /app/build /usr/share/nginx/html
# We do not have to overwrite the command since the default
# nginx command starts the nginx service. 
