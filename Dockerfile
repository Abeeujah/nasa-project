# Node.js on a minimalist linux OS..
FROM node:16-alpine

# WorkDir of your program..
WORKDIR /app

# Copy Program from Workspace to WorkDir..
COPY package*.json ./

# Commands to run the Program..
COPY client/package*.json client/
RUN npm run install-client --only=production

COPY server/package*.json server/
RUN npm run install-server --only=production

COPY client/ client/
RUN npm run build --prefix client

COPY server/ server/
# Law of least privileges..
USER node

# Commands to Start the Program..
CMD [ "npm", "start", "--prefix", "server" ]

# Port to be Exposed for the Program to work..
EXPOSE 8000