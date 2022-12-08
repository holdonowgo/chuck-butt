<!-- Improved compatibility of back to top link: See: https://github.com/othneildrew/Best-README-Template/pull/73 -->

<a name="readme-top"></a>

<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Don't forget to give the project a star!
*** Thanks again! Now go create something AMAZING! :D
-->

<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/holdonowgo/chuckster">
    <img src="images/logo.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">Chuckster</h3>

  <p align="center">
    a little Twitter clone
    <br />
    <a href="https://github.com/holdonowgo/chuckster"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/holdonowgo/chuckster">View Demo</a>
    ·
    <a href="https://github.com/holdonowgo/chuckster/issues">Report Bug</a>
    ·
    <a href="https://github.com/holdonowgo/chuckster/issues">Request Feature</a>
  </p>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->

## About The Project

[![Product Name Screen Shot][product-screenshot]](https://example.com)

Here's a blank template to get started: To avoid retyping too much info. Do a search and replace with your text editor for the following: `github_username`, `repo_name`, `twitter_handle`, `linkedin_username`, `email_client`, `email`, `project_title`, `project_description`

<p align="right">(<a href="#readme-top">back to top</a>)</p>

### Built With

- [![Next][next.js]][next-url]
- [![React][react.js]][react-url]
- [![Vue][vue.js]][vue-url]
- [![Angular][angular.io]][angular-url]
- [![Svelte][svelte.dev]][svelte-url]
- [![Laravel][laravel.com]][laravel-url]
- [![Bootstrap][bootstrap.com]][bootstrap-url]
- [![JQuery][jquery.com]][jquery-url]

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- GETTING STARTED -->

## Getting Started

This is an example of how you may give instructions on setting up your project locally.
To get a local copy up and running follow these simple example steps.

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.

- npm

  ```sh
  npm install npm@16 -g
  npm install ts-node -g
  ```

### Database

1. Install [postgresql](https://daily-dev-tips.com/posts/installing-postgresql-on-a-mac-with-homebrew/)

   ```sh
   brew update
   brew doctor
   brew install postgresql

   <!-- start postgres -->
   brew services start postgresql
   
   <!-- stop postgres -->
   brew services stop postgresql
   ```

2. Create Database

   ```sh
   psql postgres
   ```

   ```sql
   CREATE ROLE ${role} WITH LOGIN PASSWORD ${password};
   ALTER ROLE ${role} CREATEDB;
   CREATE DATABASE chuckster OWNER ${role}
   ```

3. Run DB Migrations

   - from root directory of project

   ```sh
   ts-node ./db/migrate.ts
   ```

4. Populate DB with seed data
   - TBA

### Installation

1. Clone the repo

   ```sh
   git clone https://github.com/holdonowgo/chuck-butt.git
   ```

2. Install NPM packages

   ```sh
   npm install
   ```

3. Setup your local `.env` file

   - from project root dir

   ```sh
   touch .env
   ```

   - The `.env` file should have the values for the keys listed below.  Edit the values as needed

   ```sh
    PORT=8000

    <!-- development | test | production -->
    NODE_ENV=development 

    <!-- dev values -->
    DEV_JWT_SECRET=secret
    DEV_DATABASE_NAME=chuckster
    DEV_DATABASE_URL=postgres://Randall.Spencer:postgres@localhost:5432/chuckster
    DEV_DATABASE_USERNAME=Randall.Spencer
    DEV_DATABASE_PASSWORD=

    <!-- test values -->
    TEST_JWT_SECRET=secret
    TEST_DATABASE_NAME=chuckster
    TEST_DATABASE_URL=postgres://postgres:postgres@localhost:5432/chuckster-test
    TEST_DATABASE_USERNAME=testusername
    TEST_DATABASE_PASSWORD=testpassword

    <!-- prod values -->
    JWT_SECRET=secret
    DATABASE_NAME=chuckster
    DATABASE_URL=postgres://postgres:postgres@localhost:5432/chuckster
    DATABASE_USERNAME=produsername
    DATABASE_PASSWORD=prodpassword
   ```

4. Create pub/priv keys

   - This key will be used as the JWT secret to sign JWT tokens

    ```sh
    <!-- In project root directory -->
    
    <!-- private key -->
    ssh-keygen -t rsa -b 4096 -m PEM -f jwtRS256.key

    <!-- public key -->
    openssl rsa -in jwtRS256.key -pubout -outform PEM -out jwtRS256.key.pub
    ```

   - See `src/index.ts` for usage

    ```ts
    const RSA_PRIVATE_KEY = fs.readFileSync(__dirname + '/../jwtRS256.key');
    ```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- USAGE EXAMPLES -->

## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ROADMAP -->

## Roadmap

- [ ] Feature 1
- [ ] Feature 2
- [ ] Feature 3
  - [ ] Nested Feature

See the [open issues](https://github.com/holdonowgo/chuckster/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTRIBUTING -->

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- LICENSE -->

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- CONTACT -->

## Contact

Your Name - [@twitter_handle](https://twitter.com/twitter_handle) - email@email_client.com

Project Link: [https://github.com/holdonowgo/chuckster](https://github.com/holdonowgo/chuckster)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- ACKNOWLEDGMENTS -->

## Acknowledgments

- []()
- []()
- []()

<p align="right">(<a href="#readme-top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->

[contributors-shield]: https://img.shields.io/github/contributors/holdonowgo/chuckster.svg?style=for-the-badge
[contributors-url]: https://github.com/holdonowgo/chuckster/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/holdonowgo/chuckster.svg?style=for-the-badge
[forks-url]: https://github.com/holdonowgo/chuckster/network/members
[stars-shield]: https://img.shields.io/github/stars/holdonowgo/chuckster.svg?style=for-the-badge
[stars-url]: https://github.com/holdonowgo/chuckster/stargazers
[issues-shield]: https://img.shields.io/github/issues/holdonowgo/chuckster.svg?style=for-the-badge
[issues-url]: https://github.com/holdonowgo/chuckster/issues
[license-shield]: https://img.shields.io/github/license/holdonowgo/chuckster.svg?style=for-the-badge
[license-url]: https://github.com/holdonowgo/chuckster/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username
