# Aptos RockPaperScissors Game

This repository is an **Aptos-related project** that implements a **Rock, Paper, Scissors** game on the Aptos blockchain. Players can challenge the computer in multiple rounds, and the game keeps track of both the player and computer's wins. Each game round uses randomness to generate the computer's move, and the game can be restarted for endless gameplay.

## Features

### Core Game Mechanics
- Players can select their move (Rock, Paper, or Scissors) by entering a corresponding number.
- The computer's move is randomly generated using Aptos' randomness module.
- The outcome of each round is automatically calculated, determining whether the player wins, the computer wins, or it's a draw.

### Game Flow
1. **Start a New Game**: Initializes a game session for the player.
2. **Player Makes a Move**: The player chooses their move (Rock, Paper, or Scissors) by entering the corresponding number.
3. **Computer Makes a Move**: The computer's move is randomly generated.
4. **Determine Winner**: The game calculates the winner based on the player's and computer's moves.
5. **Restart for Endless Play**: After the round ends, the game can be reset to allow continuous play without redeploying the contract.

### Scorekeeping
- The contract keeps track of the player's and the computer's number of wins across multiple rounds.
- The win totals persist, providing an ongoing score.

## Numeric Representations in the Game

To interact with the game, both the player’s move and the game result are represented by specific numbers. These numbers are used to make the game logic simple and efficient.

### Player Move Selection:
- **Enter 1 for Rock**: Rock beats Scissors but loses to Paper.
- **Enter 2 for Paper**: Paper beats Rock but loses to Scissors.
- **Enter 3 for Scissors**: Scissors beats Paper but loses to Rock.

### Game Results:
- **1 = Draw**: The player and computer made the same move.
- **2 = Player Wins**: The player's move beats the computer's move.
- **3 = Computer Wins**: The computer's move beats the player's move.

## Additional Features

1. **Endless Gameplay**: 
   - After each round, players can restart the game using the `restart_game` function, allowing for continuous play.
   
2. **Keeping Score**: 
   - The contract tracks the total number of wins for both the player and the computer over multiple rounds. This helps players track their overall performance against the computer.

## Functions Overview

### Game Setup
- **start_game**: Initializes a new game for the player.
- **set_player_move**: Allows the player to set their move (Rock, Paper, or Scissors) by entering a number (1 for Rock, 2 for Paper, 3 for Scissors).
- **randomly_set_computer_move**: Randomly generates the computer's move using Aptos' randomness module.
- **finalize_game_results**: Determines the winner of the current round and updates the score accordingly.

### Endless Gameplay & Scorekeeping
- **restart_game**: Resets the game state, enabling the player to start a new round.
- **get_player_wins**: Returns the total number of rounds won by the player.
- **get_computer_wins**: Returns the total number of rounds won by the computer.

### View Functions
- **get_player_move**: Retrieves the last move made by the player.
- **get_computer_move**: Retrieves the last move made by the computer.
- **get_game_results**: Retrieves the result of the last round (Player Win, Computer Win, or Draw).

## Example Usage

### Step-by-Step Guide:

1. **Start a New Game**:
   ```move
   RockPaperScissors::start_game(&signer);
   ```
   This initializes the game session for the player.

2. **Player Makes a Move**:
   ```move
   RockPaperScissors::set_player_move(&signer, 1); // Player chooses Rock
   ```
   Players input the number corresponding to their move:
   - `1` for Rock
   - `2` for Paper
   - `3` for Scissors

3. **Computer Randomly Makes a Move**:
   ```move
   RockPaperScissors::randomly_set_computer_move(&signer);
   ```
   This randomly generates the computer's move.

4. **Determine Game Results**:
   ```move
   RockPaperScissors::finalize_game_results(&signer);
   ```
   The game calculates whether the player won, the computer won, or it was a draw.

5. **Check Results and Score**:
   - **Player's Last Move**:
     ```move
     RockPaperScissors::get_player_move(signer_address);
     ```
   - **Computer's Last Move**:
     ```move
     RockPaperScissors::get_computer_move(signer_address);
     ```
   - **Game Results** (1 = Draw, 2 = Player Wins, 3 = Computer Wins):
     ```move
     RockPaperScissors::get_game_results(signer_address);
     ```

6. **Restart the Game**:
   ```move
   RockPaperScissors::restart_game(&signer);
   ```
   Resets the game for a new round while keeping track of the scores.

7. **Check Total Wins**:
   - **Player Wins**:
     ```move
     RockPaperScissors::get_player_wins(signer_address);
     ```
   - **Computer Wins**:
     ```move
     RockPaperScissors::get_computer_wins(signer_address);
     ```

## Installation & Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/imacpowers/APTOS-RANDOMNESS.git
   cd APTOS-RANDOMNESS
   ```

2. Compile and deploy the `RockPaperScissors.move` file to your Aptos account using the Aptos CLI.

3. Start playing by interacting with the contract functions!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Enjoy challenging the computer in endless rounds of Rock, Paper, Scissors while tracking your wins on the Aptos blockchain!
