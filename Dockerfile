# Use Ubuntu as the base image
FROM ubuntu:latest

# Install necessary packages
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install --break-system-packages pandas numpy seaborn matplotlib scikit-learn scipy

# Create the working directory
RUN mkdir -p /home/doc-bd-a1

# Set the working directory
WORKDIR /home/doc-bd-a1

# Copy the dataset into the container
COPY iris.csv /home/doc-bd-a1/

# Open bash shell on container startup
CMD ["/bin/bash"]