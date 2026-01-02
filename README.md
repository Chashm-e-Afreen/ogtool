# ogtool (SvelteKit + Podman)

A containerized, type-safe application. This project uses PureScript for the core logic and SvelteKit for the frontend framework, all managed within a Podman environment.

## 🚀 Getting Started

### Development (Local Server)

Uses `DockerfileDev` to run the local Vite development server with Hot Module Replacement (HMR).

1. Build the dev image:

    ```bash
    podman build -t ogtool-dev -f DockerfileDev
    ```

2. Run the container:

    ```bash
    podman run -p 5173:5173 -v $(pwd):/app ogtool-dev
    ```

3. Access the app:
    Open your browser to [http://localhost:5173](http://localhost:5173).

### Production Build

Uses the standard `Dockerfile` to build the optimized production assets and serve them.

1. Build the production image:

    ```bash
    podman build -t ogtool-prod -f Dockerfile
    ```

2. Run the container:

    ```bash
    podman run -p 4173:4173 ogtool-prod
    ```

3. Access the app:
    Open your browser to [http://localhost:4173](http://localhost:4173).

## 🧩 Key Features

- **Dual Dockerfile Setup**: Specialized environments for rapid development and optimized production serving.
- **Svelte Reactivity and Markup**: This app leverages Svelte's markup to build reusable UI components while keeping all the business logic in type-safe PureScript.
- **Type-Safe State and Actions**: The Increment and Decrement operations are defined as PureScript Sum Types while the State is a Purescript Record  fs(Product type).
- **TailwindCSS Styling**: This project includes TailwindCSS V4 for styling.

