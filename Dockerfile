FROM toschwarz/hugo-builder
COPY . .
RUN mkdir /build && hugo --destination "/build"
FROM nginx:alpine
COPY --from=0 /build /usr/share/nginx/html
