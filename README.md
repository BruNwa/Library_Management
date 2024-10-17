# 📚 Library Management System

A Docker-based library management system with MySQL database integration. This system provides a complete solution for managing books, users, borrowing operations, and fine management through a command-line interface.

## 🚀 Features

### 📖 Book Management
- Add new books to the inventory
- Delete books from the system
- Update book availability
- Display all books
- View current inventory status

### 👥 User Management
- Display all registered users
- Add new users
- Delete existing users
- Update user information

### 📅 Borrow & Return
- Process book borrowing
- Handle book returns
- View all borrowed books
- Track unreturned books
- Check available books
- View books borrowed by specific users

### 💸 Fine Management
- Display all fines
- Look up fines by user
- Cancel individual fines
- Cancel all fines

## 🛠️ Requirements
- Docker
- Docker Compose

## 🏗️ Setup & Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/BruNwa/Library_Management.git
    cd Library_Management
    ```

2. Start the containers:
    ```bash
    docker-compose up -d
    ```

The application will be running in the container named `appContainer`.

## 🔐 Default Credentials

### Database Access:
- **Username:** `library_user`
- **Password:** `user`
- **Database:** `library_db`

### Application Access:
- **App Password:** `root`
- **SQL Password:** `root`

## 📁 Project Structure

```plaintext
.
├── docker-compose.yml
├── Dockerfile
├── libraryApp/
│   ├── entrypoint.sh
│   ├── startup.sh
│   ├── book_management.sh
│   ├── user_management.sh
│   ├── borrow_return.sh
│   └── fine_management.sh
└── mysql_scripts/
    └── init-db.sql


## 🚀 Usage

After starting the containers, the system will present a menu with options for:
- Book Management
- User Management
- Borrow/Return
- Fines

To interact with the app:

**Enter the app container (m3lib):**
   ```bash
   docker exec -it appContainer m3lib

## 🗂️ Database Structure

Below is the database structure for the Library Management System:

![Database Structure](https://i.postimg.cc/8Cp7VPY1/libv2-drawio.png "Library Database Structure")


### Contributors:
<table>
 <td align="center">
      <a href="https://github.com/BruNwa">
        <img src="https://avatars.githubusercontent.com/u/106646716?v=4" width="100px;" alt="Zaim Anwar"/><br />
        <sub><b>Zaim Anwar</b></sub>
    </td>
  <tr>
    <td align="center">
      <a href="https://github.com/leonkam">
        <img src="https://avatars.githubusercontent.com/u/56262178?v=4" width="100px;" alt="Leonkam"/><br />
        <sub><b>Leonkam</b></sub>
    </td>
    <td align="center">
      <a href="https://github.com/Vikiyuk">
        <img src="https://avatars.githubusercontent.com/u/83815878?v=4" width="100px;" alt="Yurii Maisuradze"/><br />
        <sub><b>Yurii Maisuradze</b></sub>
    </td>
    <td align="center">
      <a href="https://github.com/Ahmad-Fakhouri">
        <img src="https://avatars.githubusercontent.com/u/116568413?v=4" width="100px;" alt="Ahmad Fakhouri"/><br />
        <sub><b>Ahmad Fakhouri</b></sub>
    </td>
  </tr>
</table>