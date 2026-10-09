# Customers Demo

A small full-stack demo application built with Flutter and Smalltalk (Pharo).

The Flutter frontend retrieves customer data from a REST API implemented in Smalltalk. It displays customers and allows each customer card to be expanded to view their bills.

The repository includes a Dockerized backend so the API can be started without manually configuring a Pharo image.

## Technologies

- **Frontend:** Flutter and Dart
- **Backend:** Pharo Smalltalk
- **HTTP API:** Zinc HTTP Components
- **JSON serialization:** NeoJSON
- **Backend environment:** Docker and Docker Compose

## Project structure

```text
customers-demo/
├── backend/
│   ├── Person.st
│   ├── PersonsRepository.st
│   ├── PersonsApi.st
│   └── start.st
├── frontend/
│   └── ...
├── Dockerfile
├── compose.yaml
├── .gitignore
└── README.md
```

- `Person.st` — customer model
- `PersonsRepository.st` — sample customer data
- `PersonsApi.st` — REST API implementation
- `start.st` — loads the backend source files and starts the API
- `Dockerfile` — builds the backend container
- `compose.yaml` — configures the backend service
- `frontend/` — Flutter application

## Requirements

To run the backend:
- Git
- Docker
- Docker Compose (the `docker compose` command)

To run the frontend:
- Flutter SDK
- The platform-specific tools required by Flutter for your target device

## Running the backend

From the repository root, run:

```bash
docker compose up --build -d
```

Docker builds the backend image, installs the required NeoJSON dependency, and starts the Pharo API.

The first build may take some time and requires an internet connection to download the base image and dependencies.

The API listens on port `8081`.

### Test the API

Send a GET request to:

```text
http://localhost:8081/api/persons
```

For example, using curl:

```bash
curl http://localhost:8081/api/persons
```

The endpoint returns a JSON array containing sample customers, including their names, ages, addresses, and bills.

To stop the backend, run:

```bash
docker compose down
```

## Running the frontend

Open a terminal in the `frontend/` directory.

### 1. Install dependencies

```bash
flutter pub get
```

### 2. Run the application

For a supported Linux desktop environment:

```bash
flutter run -d linux
```

Alternatively, use `flutter run` to select an available device.

### 3. Connect to the backend

Start the backend first and ensure the frontend can reach the API at:

```text
http://localhost:8081/api/persons
```

The frontend must use an address that is reachable from the device running it.

- **Linux desktop:** `localhost` can reach the API published on the host's port `8081`.
- **Android emulator:** `localhost` refers to the emulator itself. For the standard Android Emulator, use `10.0.2.2` to reach the host machine, and update the API URL in the frontend if necessary.
- **Physical device:** use the host computer's reachable LAN address and ensure network and firewall settings permit the connection.
