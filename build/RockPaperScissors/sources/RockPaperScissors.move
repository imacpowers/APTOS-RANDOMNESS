address  0x15d5e468bdb91057e43552fdf4778205a7c1f427b58df96fa2e4f215a57a2b65 {

module RockPaperScissors {
    use std::signer;
    use aptos_framework::randomness;

    const ROCK: u8 = 1;
    const PAPER: u8 = 2;
    const SCISSORS: u8 = 3;
    const PLAYER_WINS: u8 = 2;
    const DRAW: u8 = 1;
    const COMPUTER_WINS: u8 = 3;

    struct Game has key {
        player: address,
        player_move: u8,
        computer_move: u8,
        result: u8,
        player_wins: u32,
        computer_wins: u32,
    }

    public entry fun start_game(account: &signer) {
        let player = signer::address_of(account);

        let game = Game {
            player,
            player_move: 0,
            computer_move: 0,
            result: 0,
            player_wins: 0,
            computer_wins: 0,
        };

        move_to(account, game);
    }

    public entry fun set_player_move(account: &signer, player_move: u8) acquires Game {
        let game = borrow_global_mut<Game>(signer::address_of(account));
        game.player_move = player_move;
    }

    #[randomness]
    entry fun randomly_set_computer_move(account: &signer) acquires Game {
        randomly_set_computer_move_internal(account);
    }

    public(friend) fun randomly_set_computer_move_internal(account: &signer) acquires Game {
        let game = borrow_global_mut<Game>(signer::address_of(account));
        let random_number = randomness::u8_range(1, 4);
        game.computer_move = random_number;
    }

    public entry fun finalize_game_results(account: &signer) acquires Game {
        let game = borrow_global_mut<Game>(signer::address_of(account));
        let result = determine_winner(game.player_move, game.computer_move);

        game.result = result;

        if (result == PLAYER_WINS) {
            let current_player_wins = game.player_wins;
            game.player_wins = current_player_wins + 1;
        } else if (result == COMPUTER_WINS) {
            let current_computer_wins = game.computer_wins;
            game.computer_wins = current_computer_wins + 1;
        }
    }

    public entry fun restart_game(account: &signer) acquires Game {
        let game = borrow_global_mut<Game>(signer::address_of(account));
        game.player_move = 0;
        game.computer_move = 0;
        game.result = 0;
    }

    fun determine_winner(player_move: u8, computer_move: u8): u8 {
        if (player_move == ROCK && computer_move == SCISSORS) {
            PLAYER_WINS
        } else if (player_move == PAPER && computer_move == ROCK) {
            PLAYER_WINS
        } else if (player_move == SCISSORS && computer_move == PAPER) {
            PLAYER_WINS
        } else if (player_move == computer_move) {
            DRAW
        } else {
            COMPUTER_WINS
        }
    }

    #[view]
    public fun get_player_move(account_addr: address): u8 acquires Game {
        borrow_global<Game>(account_addr).player_move
    }

    #[view]
    public fun get_computer_move(account_addr: address): u8 acquires Game {
        borrow_global<Game>(account_addr).computer_move
    }

    #[view]
    public fun get_game_results(account_addr: address): u8 acquires Game {
        borrow_global<Game>(account_addr).result
    }

    #[view]
    public fun get_player_wins(account_addr: address): u32 acquires Game {
        borrow_global<Game>(account_addr).player_wins
    }

    #[view]
    public fun get_computer_wins(account_addr: address): u32 acquires Game {
        borrow_global<Game>(account_addr).computer_wins
    }

}
}
