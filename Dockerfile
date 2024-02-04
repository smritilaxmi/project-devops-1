# Use the base image
FROM devopsedu/webapp

# Set the working directory inside the container
WORKDIR /var/www/html

# Copy the PHP website files to the container
COPY . /var/www/html

# Remove the default index.html file from the base image
RUN rm /var/www/html/index.html

# Expose the port the app runs on
EXPOSE 80

# Command to run the PHP application
CMD ["apachectl", "-D", "FOREGROUND"]
