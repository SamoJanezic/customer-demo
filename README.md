# Customers Demo

A small full-stack application built with Flutter and Smalltalk (Pharo).

The Flutter frontend retrieves customer data from a REST API implemented in Smalltalk. The app displays customers and allows each customer to expand their card to view their bills.

## Technologies

- **Frontend:** Flutter and Dart
- **Backend:** Pharo Smalltalk
- **HTTP API:** Zinc HTTP Components
- **JSON:** NeoJSON

## Project structure

- `frontend/` — Flutter application
- `backend/Person.st` — customer model
- `backend/PersonsRepository.st` — sample customer data
- `backend/PersonsApi.st` — HTTP API

## API endpoint

`GET /api/persons`

The endpoint returns a JSON array of customers, including their names, ages, and bills.

## Running the project

### Backend

1. Open the Pharo image in which the required dependencies are installed.
2. Load the backend classes from `backend/` if they are not already present.
3. Start the API using:

   ```smalltalk
   api := PersonsApi new.
   api start.
   ```

The API listens on port `8081`.

### Frontend

1. Install Flutter.
2. Open a terminal in `frontend/`.
3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app:

   ```bash
   flutter run
   ```

The frontend currently requests the API at `http://localhost:8081/api/persons`. The API must be running and reachable from the device or emulator running Flutter. On an Android emulator, `localhost` refers to the emulator itself, so use the host machine's emulator-accessible address instead.