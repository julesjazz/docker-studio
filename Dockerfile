# busybox sindre
FROM node:16-alpine AS studio

WORKDIR /srv
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npx @sanity/cli build

FROM busybox:1.35

RUN adduser -D static
USER static
WORKDIR /home/static

COPY --from=studio /srv/dist .

# Run BusyBox httpd
CMD ["busybox", "httpd", "-f", "-v", "-p", "3333"]

# # FROM node:16-alpine
# # WORKDIR /dist
# # COPY . .
# # RUN npm ci
# # RUN npm run start
# # # RUN npm run build
# # ENV NODE_ENV development
# # # ENV NODE_ENV production
# # EXPOSE 3333
# # CMD ["npx", "start"]

# FROM node:18.7.0-alpine
# # set working directory
# WORKDIR /app
# # add `/app/node_modules/.bin` to $PATH
# ENV PATH /app/node_modules/.bin:$PATH
# # install app dependencies
# COPY package.json ./
# COPY package-lock.json ./
# RUN npm install -g @sanity/cli
# RUN npm install usehooks-ts@2.1.1
# # add app
# COPY . ./
# RUN npm run build
# EXPOSE 3333
# # start app
# # CMD ["sanity", "start"]
# CMD ["npm", "run", "start"]

# # docker run --expose 3333 -p 3333:3333 test:123
# # docker run -d -it –rm -p 3333:3333 -name studiotest test:123
# # docker run -p 3333:3333 test:123
# # docker run -d -p 3333:3333 test:123