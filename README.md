
# Project Document: Classroom Chat and File Sharing Application

## Table of Contents
1. [Introduction](#introduction)
2. [Project Objectives](#project-objectives)
3. [Technologies Used](#technologies-used)
4. [Architecture](#architecture)
5. [Dependencies](#dependencies)
   - [Client-side (Flutter)](#client-side-flutter)
   - [Server-side (Node.js)](#server-side-nodejs)
6. [Features](#features)
7. [Setup and Installation](#setup-and-installation)
   - [Client-side](#client-side)
   - [Server-side](#server-side)
8. [Usage](#usage)

## Introduction

This project is a chat and file-sharing application designed for classroom use, enabling students to communicate and share files seamlessly. The application is built using Flutter for the client side, following the clean architecture principles, and Node.js with TypeScript for the server side, utilizing MongoDB for data storage.

## Project Objectives

- Provide a platform for students to chat and share files in a classroom setting.
- Ensure a clean and maintainable codebase by adhering to clean architecture principles.
- Utilize modern technologies and best practices for both client-side and server-side development.

## Technologies Used

### Client-side (Flutter)
- **Flutter**: A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- **Clean Architecture**: Ensures separation of concerns, making the codebase more maintainable and testable.

### Server-side (Node.js with TypeScript)
- **Node.js**: A JavaScript runtime built on Chrome's V8 JavaScript engine.
- **TypeScript**: A typed superset of JavaScript that compiles to plain JavaScript.
- **MongoDB**: A NoSQL database for storing user information, messages, and files.

## Architecture

### Client-side
The Flutter application is structured following clean architecture principles, which separates the code into distinct layers:
1. **Presentation Layer**: Manages the UI and user interaction, using Flutter widgets.
2. **Domain Layer**: Contains business logic and application-specific rules.
3. **Data Layer**: Handles data retrieval and storage, interacting with external data sources like the server API.

### Server-side
The server is built using Node.js and TypeScript, structured into:
1. **API Layer**: Handles incoming HTTP requests, routing, and response formatting.
2. **Service Layer**: Contains the core business logic and operations.
3. **Data Access Layer**: Interacts with MongoDB for data storage and retrieval.

## Dependencies

### Client-side (Flutter)
```yaml
dependencies:
  cupertino_icons: ^1.0.6
  flutter_bloc: ^8.1.5
  equatable: ^2.0.5
  google_fonts: ^6.2.1
  fpdart: ^1.1.0
  http: ^1.2.1
  get_it: ^7.7.0
  url_launcher: ^6.2.6
  socket_io_client: ^2.0.3+1
  intl: ^0.19.0
  file_picker: ^8.0.3
  flutter_secure_storage: ^9.2.2
  flutter_markdown: ^0.7.1
  markdown: ^7.2.2
  flutter_dotenv: ^5.1.0
```
### Server-side (Node.js)
```json
{
  "name": "socket_server",
  "version": "1.0.0",
  "main": "index.js",
  "scripts": {
    "start": "nodemon src/index.ts",
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "dependencies": {
    "@types/express": "^4.17.21",
    "@types/mongoose": "^5.11.97",
    "@types/multer": "^1.4.11",
    "@types/socket.io": "^3.0.2",
    "body-parser": "^1.20.2",
    "cors": "^2.8.5",
    "dotenv": "^16.4.5",
    "express": "^4.19.2",
    "http": "^0.0.1-security",
    "mongoose": "^8.3.5",
    "morgan": "^1.10.0",
    "multer": "^1.4.5-lts.1",
    "nodemon": "^3.1.0",
    "path": "^0.12.7",
    "socket.io": "^4.7.5"
  },
  "devDependencies": {
    "typescript": "^5.4.5"
  }
}
```
## Features
 - Real-time Chat: Enables real-time messaging between users.
 - File Sharing: Allows users to share various types of files within the chat.
 - User Authentication: Secure user authentication and storage using Flutter Secure Storage and MongoDB.

## Setup and Installation

 - ### Client-side
   - #### Clone the Repository:

	  ```sh
	  git clone <repository-url>
	  cd <repository-directory>
	  ```
    - #### Install Dependencies:

	  ```sh
	  flutter pub get
	  ```
   -  #### Run the Application:
		```sh
		flutter run
		```
   
 - ### Server-side
    - #### Install Dependencies:
		```sh
		npm install
		```
	- #### Start the Server:
		```sh
		npm start
		```
		
## Usage
 - Start the client application: Ensure the Flutter app is running on your desired platform (mobile, web, desktop).
 - Start the server: Make sure the Node.js server is up and running.
 - Connect to the server: The Flutter app will connect to the Node.js server for real-time communication and data exchange.
 - Use the app:log in, start chatting with classmates, and share files as needed.
