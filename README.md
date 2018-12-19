# managehomeschool application
### Ruby Version:
```
2.5.3
```

### DB:
Uses postgresql on mac we can install using
```
brew install postgresql
brew tap homebrew/services
brew services start postgresql
```

First time setting up
```
rails db:create
rails db:migrate
```
To drop the DB:
```
rails db:drop
```

### System dependencies:
```
The system dependencies are stated in the Gemfile
```

### TODO:
1) Deployment instructions
2) Services (job queues, cache servers, search engines, etc.)
3) How to run the test suite
4) Create DB seed data
