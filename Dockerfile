# Use the official Node.js image as the base image
FROM node:latest

# Set the working directory
WORKDIR /app

# Copy the files from the local machine to the container
COPY . .

# Install Python and Pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get clean

# Install Node.js dependencies
RUN rm -rf apps/browser-chat/node_modules/.vite || true && \
    npm install -g pnpm && \
    pnpm install

# Install Python dependencies
RUN pip install -r apps/embeddings-apis/sentence-embedder/requirements.txt && \
    pip install -r apps/embeddings-apis/similarity-search/requirements.txt

# Expose the port for the application to run on
EXPOSE 5173

# Start the application
CMD ["pnpm", "start"]
