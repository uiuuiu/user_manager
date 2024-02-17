### How to run
1. Run docker build
  ```
  docker-compose up --build
  ```
2. Create database and data
  ```
  docker-compose run app ./bin/rails db:drop db:create db:migrate db:seed
  ```
3. Access to `localhost:3000`
