# Aider CLI Tool Environment

This repository provides a Nix Flake configuration for setting up an environment to use the [Aider CLI tool](https://aider.chat/). The environment is configured to ensure all necessary dependencies are available and the `aider` command is ready to use.

## Purpose

The purpose of this flake is to create a reproducible environment for using the Aider CLI tool. By using Nix Flakes, we ensure that the environment is consistent across different machines and setups.

## Usage

1. **Clone the Repository**:
   ```sh
   git clone <repository-url>
   cd <repository-directory>
   ```

2. **Enter the Development Shell**:
   ```sh
   nix develop
   ```

   This command will drop you into a shell with all the dependencies set up and the `aider` command available.

3. **Using the `aider` Command**:
   Once inside the shell, you can use the `aider` command as needed. For more information on how to use `aider`, refer to the [Aider CLI tool documentation](https://aider.chat/) and the [GitHub repository](https://github.com/paul-gauthier/aider).

## Configuration Details

The environment is defined in the `flake.nix` file. It includes:
- Python 3 and essential Python packages (`virtualenv`, `pip`, `setuptools`, `wheel`).
- A virtual environment (`.venv`) that is automatically created and activated.
- The `aider` CLI tool is installed and upgraded within the virtual environment.
- The `PATH` is configured to include the virtual environment's `bin` directory.

For more details, refer to the `flake.nix` file in this repository.
