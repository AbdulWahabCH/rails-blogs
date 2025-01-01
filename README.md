# Rails Blog
A basic rails blog application using rails v7.2 and tailwindcss.

## Description
Rails blog app with minimal functionality of creating/editing/destroying blogs, and user can add other users as colabs with limited authority. Users have given a profile options where their posted blogs are orchestrated.

## Installation
1. Clone the repository:
   ```bash
  git clone https://github.com/AbdulWahabCH/rails-blogs.git
  cd rails-blogs
  ```
2. Set up .env file
  ```bash
  DATABASE_URL=your-managed-database-url
  ACCESS_KEY_ID=your-aws-access-key-id
  SECRET_ACCESS_KEY=your-aws-secret-access-key
  ```
3. Run project
  ```bash
  bundle install
  rails db:setup
  rails server
  ```
