# MRBS Docker Project

This project uses Docker to deploy the [MRBS (Meeting Room Booking System)](https://mrbs.sourceforge.io/), an open-source web application for managing and scheduling meetings, conference rooms, and shared spaces. This repository provides a complete environment with both the MRBS application and a MySQL database backend.

## Project Architecture

The architecture of this project consists of two main services:

1. **Web Service (PHP with Apache)**:
   - The web service hosts the MRBS application, which is written in PHP and served by Apache. It handles all user interactions, including scheduling, room management, and meeting organization.
   - This service uses the official `php:7.4-apache` image, extended to include necessary PHP extensions (`pdo_mysql` and `mysqli`) for MySQL database connectivity.

2. **Database Service (MySQL)**:
   - The database service provides a MySQL 5.7 database, which stores all MRBS data, including user accounts, room information, and booking schedules.
   - The MySQL container is configured to initialize with a database named `mrbs` and a user with the required permissions to interact with it.

### Docker Compose Architecture

- The `docker-compose.yml` file defines and coordinates these services.
- `db` service (MySQL) is configured with a persistent volume to ensure data persists across container restarts.
- `web` service (Apache with PHP) depends on the `db` service, ensuring that MySQL starts before MRBS attempts to connect to it.

### Functions

The MRBS application provides the following key features:

- **Room Management**: Define and configure rooms and resources.
- **Booking and Scheduling**: Schedule meetings and bookings for available rooms.
- **User Management**: Allow user registration, login, and role-based permissions.
- **Search and Reports**: Generate reports and search bookings.

## Setup and Configuration

### Prerequisites

To run this project, ensure that the following are installed on your machine:

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Getting Started

1. **Clone the Repository**:

   ```bash
   git clone https://github.com/ramplerk15/mrbs-docker.git
   cd mrbs-docker

2. **Configuration**:

    - `config.inc.php`: The MRBS configuration file should be edited to set application-specific settings. This includes database credentials and timezone settings.

   - In the `config.inc.php`, ensure the following settings are correctly set:

      ```bash
      $dbsys = "mysql";
      $db_host = "db";
      $db_database = "mrbs";
      $db_login = "mrbs_user";
      $db_password = "my_mrbs_password";
      $timezone = "Europe/Vienna";

    - Update `docker-compose.yml` environment variables as necessary:
      ```bash
      MYSQL_DATABASE: mrbs
      MYSQL_USER: mrbs_user
      MYSQL_PASSWORD: my_mrbs_password

3. **Run Docker Compose**:

    Start the project with:

      ```bash
      docker-compose up --build

  This command will:
  - Build and start the `web` and `db` services.
  - Set up the MRBS application, Apache, and the MySQL database.

4. **Access the Application**:

   Once all containers are running, open a browser and go to:

    ```bash
    http://localhost:8080

5. **Initialize Database Tables**:

    If the tables do not initialize automatically, you can manually execute the SQL statements for creating tables.

    Copy the SQL Statements from `tables.my.sql` and paste them directly into the MySQL shell:
    (Enter the password `my_mrbs_password` when prompted, then paste the SQL statements into the shell.)

     ```bash
     docker exec -it mrbs_db mysql -u mrbs_user -p mrbs
  
###Additional Notes

  - **Data Persistence**: The MySQL data is stored in a Docker volume (`db_data`), so it will persist across container restarts. To clear all data, use:

    ```bash
    docker-compose down -v

  - **Logs**: Access container logs with:

    ```bash
    docker-compose logs

  - **Shutting Down**: Stop all containers with:

    ```bash
    docker-compose down

###Troubleshooting

  - **403 Forbidden**: Ensure the permissions on MRBS files are set correctly and Apache has access.
  - **Database Connection Errors**: Verify MySQL credentials in both `config.inc.php` and `docker-compose.yml`.
  - **Batch Readline Errors**: Run SQL statements manually in MySQL shell if encountering issues.
